#!/usr/bin/env bash

# Decides which wallpaper each display gets, and sets it.
#
# `hyprctl hyprpaper` does NOT work on this setup: hyprctl from Hyprland 0.55
# speaks the newer hyprwire protocol, while hyprpaper 0.7.6 still uses the
# plaintext socket. So talk to that socket directly instead.
#
# usage:
#   wallpaper.sh refresh             apply the tables below to every display
#   wallpaper.sh reload              same, but drop hyprpaper's cached images
#                                    first -- for when you edited an image file
#                                    in place and want to see the new version
#   wallpaper.sh show                print what each display gets, and why
#   wallpaper.sh <image> [monitor]   set one display by hand
#   wallpaper.sh random  [monitor]
#
#   --fit cover     fill the screen, cropping the overflow (default, and the
#                   same as macOS "Fill Screen")
#   --fit contain   show the whole image, adding black bars (macOS "Fit")
#   --fit tile      repeat the image
#
#   refresh   re-applies the tables on every connected output. monitors.lua
#             calls this on plug and unplug, and autostart.lua at login.
#             hyprpaper 0.7.6 needs the nudge regardless of the tables: left to
#             itself it keeps painting a stale buffer when outputs come and go.

set -euo pipefail

wallpapers="$HOME/.config/hypr/wallpapers"
sock="$XDG_RUNTIME_DIR/hypr/${HYPRLAND_INSTANCE_SIGNATURE:-}/.hyprpaper.sock"

# hyprpaper's listactive only ever reports a bare path, never the fit mode, so a
# refresh has no way to recover it from the daemon. Keep our own note of it.
fit_state="$XDG_RUNTIME_DIR/hypr-wallpaper-fit"

# ─── which wallpaper goes where ───────────────────────────────────────────────
#
# Values are filenames inside ~/.config/hypr/wallpapers (an absolute path works
# too), optionally carrying their own fit mode: "contain:5.jpg".
#
# BY_DISPLAY is checked first, then BY_COUNT, then DEFAULT.

# Keyed on how many displays are connected. This is the broad stroke: every
# display that BY_DISPLAY does not name gets the entry for the current count.
declare -A BY_COUNT=(
  [1]="evangelion.png"   # laptop on its own
  [2]="main.png"         # laptop + one external
  [3]="smile.png"         # laptop + two externals
)

# Keyed on a single display, and wins over BY_COUNT. Use this to pin one screen
# while the rest follow the layout.
#
# Prefer the EDID description over the connector name: an external arrives as
# one of DP-1..DP-8 depending on which USB-C port it went into, so its name
# changes between plugs but its description does not. eDP-1 is the exception --
# the built-in panel is always eDP-1. `hyprctl monitors` prints both.
declare -A BY_DISPLAY=(
  # ["eDP-1"]="SDS-3x2.jpg"
  # ["LG Electronics 24GL600F 0x00073113"]="SDS.jpg"
)

# When neither table has an answer -- a fourth display, say.
DEFAULT="v.jpeg"

# ─────────────────────────────────────────────────────────────────────────────

fit=""
positional=()
while [ $# -gt 0 ]; do
  case "$1" in
    --fit)
      fit="${2:-}"
      shift 2
      ;;
    --fit=*)
      fit="${1#--fit=}"
      shift
      ;;
    *)
      positional+=("$1")
      shift
      ;;
  esac
done

target="${positional[0]:-random}"
monitor="${positional[1]:-eDP-1}"

case "${fit:-cover}" in
  cover) prefix="" ;;
  contain) prefix="contain:" ;;
  tile) prefix="tile:" ;;
  *)
    echo "unknown --fit '$fit' (want cover, contain or tile)" >&2
    exit 1
    ;;
esac

# the fit last chosen by hand, used for table entries that don't name one
manual_fit=""
if [ -r "$fit_state" ]; then
  manual_fit=$(cat "$fit_state")
fi

ipc() { printf '%s' "$1" | ncat -U -w1 "$sock"; }

# True only when something actually answers on the socket.
#
# Testing for the socket file is not enough: a dead hyprpaper leaves its socket
# inode behind. Verified -- after `pkill hyprpaper` the file is still there and
# connecting to it fails with "Connection refused", so a file-existence check
# sails straight past and every later command dies one by one.
hyprpaper_alive() {
  [ -S "$sock" ] && printf 'listloaded' | ncat -U -w1 "$sock" >/dev/null 2>&1
}

require_hyprpaper() {
  if ! hyprpaper_alive; then
    echo "hyprpaper is not answering on $sock — is it running?" >&2
    exit 1
  fi
}

# Same, but give it time to come up. At login we are racing hyprpaper's own
# startup, and failing there would leave every screen blank with no hint why.
await_hyprpaper() {
  local waited=0
  while ! hyprpaper_alive && [ "$waited" -lt 100 ]; do
    sleep 0.1
    waited=$((waited + 1))
  done
  require_hyprpaper
}

# name + description + display count -> "<value>\t<which rule matched>"
resolve() {
  local name=$1 desc=$2 count=$3
  if [ -n "${BY_DISPLAY[$desc]:-}" ]; then
    printf '%s\t%s\n' "${BY_DISPLAY[$desc]}" "BY_DISPLAY[$desc]"
  elif [ -n "${BY_DISPLAY[$name]:-}" ]; then
    printf '%s\t%s\n' "${BY_DISPLAY[$name]}" "BY_DISPLAY[$name]"
  elif [ -n "${BY_COUNT[$count]:-}" ]; then
    printf '%s\t%s\n' "${BY_COUNT[$count]}" "BY_COUNT[$count]"
  else
    printf '%s\t%s\n' "$DEFAULT" "DEFAULT"
  fi
}

# "contain:5.jpg" -> rule_fit="contain:" rule_path="/abs/path/5.jpg"
split_rule() {
  local value=$1
  case "$value" in
    cover:*)   rule_fit="";         value=${value#cover:} ;;
    contain:*) rule_fit="contain:"; value=${value#contain:} ;;
    tile:*)    rule_fit="tile:";    value=${value#tile:} ;;
    *)         rule_fit="$manual_fit" ;;
  esac
  case "$value" in
    /*) rule_path=$value ;;
    *)  rule_path="$wallpapers/$value" ;;
  esac
}

# name<TAB>description, one line per connected display
connected() {
  hyprctl -j monitors | jq -r '.[] | "\(.name)\t\(.description)"'
}

if [ "$target" = "show" ]; then
  count=$(hyprctl -j monitors | jq 'length')
  echo "$count display(s) connected"
  echo
  printf '%-8s %-11s %-16s %-8s %s\n' DISPLAY RESOLUTION WALLPAPER FIT RULE
  while IFS=$'\t' read -r name desc res; do
    IFS=$'\t' read -r value why < <(resolve "$name" "$desc" "$count")
    split_rule "$value"
    [ -f "$rule_path" ] || why="$why — MISSING FILE"
    printf '%-8s %-11s %-16s %-8s %s\n' \
      "$name" "$res" "$(basename "$rule_path")" "${rule_fit:-cover}" "$why"
  done < <(hyprctl -j monitors |
    jq -r '.[] | "\(.name)\t\(.description)\t\(.width)x\(.height)"')
  exit 0
fi

if [ "$target" = "refresh" ] || [ "$target" = "reload" ]; then
  # Let the compositor finish reconfiguring the layer surfaces first. Talking to
  # hyprpaper mid-reconfigure is what makes it attach a buffer to a surface that
  # has not been configured yet, which is a fatal protocol error.
  #
  # Deliberately no "restart hyprpaper if it looks dead" fallback here. That was
  # tried, and two hyprpaper instances fighting over one layer surface is far
  # worse than a missing wallpaper -- they kill each other with "Serial invalid
  # in ack_configure". hyprpaper survives displays coming and going by itself;
  # all it needs is to be told to repaint afterwards.
  # only when reacting to a hotplug; a hand-run reload has nothing to wait for
  [ "$target" = "refresh" ] && sleep "${WALLPAPER_REFRESH_DELAY:-1.5}"
  await_hyprpaper

  # `reload` is for after you edit an image file *in place*. hyprpaper caches
  # decoded images by path, and a second `preload` of a path it already holds is
  # a silent no-op -- it keeps serving the old pixels. Verified: overwriting a
  # file and re-preloading changes nothing on screen until it is unloaded first.
  # Editing the tables above needs no unload, since that changes which path is
  # asked for, so plain `refresh` is enough.
  [ "$target" = "reload" ] && ipc "unload all" >/dev/null

  count=$(hyprctl -j monitors | jq 'length')

  outputs=()
  paths=()
  while IFS=$'\t' read -r name desc; do
    IFS=$'\t' read -r value _why < <(resolve "$name" "$desc" "$count")
    split_rule "$value"
    if [ ! -f "$rule_path" ]; then
      # leave the display alone rather than blanking it
      echo "no such image for $name: $rule_path" >&2
      continue
    fi
    outputs+=("$name")
    paths+=("$rule_fit$rule_path")
  done < <(connected)

  # every image has to be preloaded before any output can be pointed at it, and
  # preload takes a bare path -- it rejects a mode prefix ("no such file")
  declare -A seen=()
  for entry in "${paths[@]}"; do
    bare=${entry#*:}
    [ -n "${seen[$bare]:-}" ] && continue
    seen[$bare]=1
    ipc "preload $bare" >/dev/null
  done

  for i in "${!outputs[@]}"; do
    ipc "wallpaper ${outputs[$i]},${paths[$i]}" >/dev/null
    echo "${outputs[$i]} -> ${paths[$i]##*/}"
  done

  ipc "unload unused" >/dev/null
  exit 0
fi

require_hyprpaper

if [ "$target" = "random" ]; then
  target=$(find "$wallpapers" -type f \( -iname '*.jpg' -o -iname '*.png' \) | shuf -n1)
elif [ ! -f "$target" ] && [ -f "$wallpapers/$target" ]; then
  # bare filenames are looked up in the wallpapers dir, same as the tables above
  target="$wallpapers/$target"
fi

if [ ! -f "$target" ]; then
  echo "no such image: $target" >&2
  exit 1
fi

# preload takes a bare path -- it rejects a mode prefix ("no such file")
ipc "preload $target" >/dev/null
ipc "wallpaper $monitor,$prefix$target" >/dev/null

# drop everything we are no longer showing, so we don't leak shared memory
ipc "unload unused" >/dev/null

printf '%s' "$prefix" > "$fit_state"

# A hand-set wallpaper lasts until the next display change: plugging or
# unplugging runs `refresh`, which goes back to the tables at the top.
echo "$monitor -> ${prefix}$target"
