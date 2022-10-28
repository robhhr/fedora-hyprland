local wezterm = require 'wezterm'

return {
  colors = {
    tab_bar = {
      active_tab = {
        bg_color = '#000',
        fg_color = '#FFF',
        intensity = 'Half',
      },
      inactive_tab = {
        bg_color = 'rgba(0, 0, 0, .25)',
        fg_color = '#FFF',
        intensity = 'Bold',
      },
    },
  },
  color_scheme = 'zenburn (terminal.sexy)',
  font = wezterm.font 'JetBrainsMono Nerd Font',
  font_size = 14.5,
  hyperlink_rules = {
    {
      regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
      format = 'mailto:$0',
    },
    {
      regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
      format = '$0',
    },
  },
  window_frame = {
    font_size = 10,
  },
  window_padding = {
    bottom = '5px',
    left = '8px',
    right = '5px',
    top = '8px',
  },
}
