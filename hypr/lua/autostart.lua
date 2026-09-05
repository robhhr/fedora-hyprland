hl.on("hyprland.start", function()
  hl.exec_cmd("dunst")
  --
  -- bare "hyprpaper" is silently not found at login if not on compositor's PATH
  hl.exec_cmd("~/.local/bin/hyprpaper")
  hl.exec_cmd("~/.config/hypr/scripts/wallpaper.sh reload")

  hl.exec_cmd("~/.config/hypr/scripts/waybar_start.sh")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("wlsunset -l 47.6062 -L -122.3321 -t 3300 -T 3800")
  hl.exec_cmd("/usr/libexec/lxqt-policykit-agent")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE")
  hl.exec_cmd("systemctl --user start hyprland-session.target")
end)
