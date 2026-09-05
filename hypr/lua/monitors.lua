-- display and hotplug handling.
local M = {}

local LAPTOP = "eDP-1"

-- candidate scales
local CANDIDATES = { 1, 1.2, 1.25, 1.5, 1.6, 2, 2.4, 3 }

local TARGET_LOGICAL_HEIGHT = 1080

-- per-display overrides
local OVERRIDES = {
  -- ["DELL U2720Q"] = 1.5,
}

local function divides_evenly(size, scale)
  local logical = size / scale
  return math.abs(logical - math.floor(logical + 0.5)) < 0.001
end

local function clean_scales(width, height)
  local out = {}
  for _, scale in ipairs(CANDIDATES) do
    if divides_evenly(width, scale) and divides_evenly(height, scale) then
      out[#out + 1] = scale
    end
  end
  return out
end

local TOLERANCE = 0.15

local function pick_scale(width, height)
  local best, best_err
  for _, scale in ipairs(clean_scales(width, height)) do
    local err = math.abs((height / scale) - TARGET_LOGICAL_HEIGHT) / TARGET_LOGICAL_HEIGHT
    if scale == math.floor(scale) and err <= TOLERANCE then
      err = 0
    end
    if not best_err or err < best_err then
      best, best_err = scale, err
    end
  end
  return best or 1
end

local function notify(title, body)
  local safe = body:gsub("'", "")
  hl.exec_cmd(string.format("notify-send '%s' '%s'", title, safe))
end

local function apply(name, scale, width, height)
  hl.monitor({
    output = name,
    mode = "preferred",
    position = "auto",
    scale = scale,
  })
  return string.format("%s at %gx -> %dx%d logical", name, scale,
    width / scale, height / scale)
end

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1,
})

hl.monitor({
  output = LAPTOP,
  mode = "preferred",
  position = "auto",
  scale = 2,
})

hl.on("monitor.added", function(mon)
  if mon.name == LAPTOP then
    return
  end

  local width, height = mon.width, mon.height
  if not width or not height or width == 0 or height == 0 then
    return
  end

  local desc = mon.description or ""
  local scale = OVERRIDES[desc] or pick_scale(width, height)
  local summary = apply(mon.name, scale, width, height)

  -- hyprpaper 0.7.6 can be left holding a stale buffer when outputs come and
  -- go, which looks like the wallpaper disappearing. Nudge it.
  hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh refresh")

  notify("Display connected", (desc ~= "" and desc or mon.name) .. " - " .. summary)
end)

hl.on("monitor.removed", function()
  hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh refresh")
end)

function M.cycle_scale()
  local mon = hl.get_active_monitor()

  if not mon or mon.name == LAPTOP then
    mon = nil
    for _, other in ipairs(hl.get_monitors() or {}) do
      if other.name ~= LAPTOP then
        if mon then
          notify("Scale", "several external displays - focus the one to change")
          return
        end
        mon = other
      end
    end
  end

  if not mon then
    notify("Scale", "no external display to change")
    return
  end

  local options = clean_scales(mon.width, mon.height)
  if #options == 0 then
    notify("Scale", mon.name .. " has no clean scale to switch to")
    return
  end

  local next_scale = options[1]
  for i, scale in ipairs(options) do
    if math.abs(scale - mon.scale) < 0.001 then
      next_scale = options[(i % #options) + 1]
      break
    end
  end

  notify("Scale", apply(mon.name, next_scale, mon.width, mon.height))
end

return M
