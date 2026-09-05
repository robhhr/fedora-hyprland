hl.config({
  general = {
    gaps_in = 4,
    gaps_out = 12,
    border_size = 3,
    layout = "dwindle",

    col = {
      -- active_border = "rgba(fabd2fff)",
      active_border = "rgba(fb4934aa)",
      inactive_border = "rgba(928374aa)"
    },
  },

  decoration = {
    rounding = 8,
  },

  input = {
    kb_layout = "us",
    kb_options = "caps:escape",
    natural_scroll = true,
  },

  misc = {
    disable_hyprland_logo = true,
    force_default_wallpaper = 0,
    -- hyprland-guiutils isn't packaged for Fedora; skip the startup nag
    disable_hyprland_guiutils_check = true,
  },
})
