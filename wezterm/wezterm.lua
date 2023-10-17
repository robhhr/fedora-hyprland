local wezterm = require 'wezterm'

local colorschemes = {
  -- light
  "rose-pine-dawn",
  "vimbones",
  -- dark
  "Cobalt2",
  "Popping and Locking",
  "SeaShells",
}

return {
  check_for_updates = true,
  check_for_updates_interval_seconds = 259200,
  color_scheme = colorschemes[5],
  colors = {
    cursor_bg = '#52ad70',
    cursor_fg = 'black',
    selection_bg = '#fffacd',
    selection_fg = 'black',
    tab_bar = {
      active_tab = {
        bg_color = 'yellow',
        fg_color = '#17384C'
      },
      inactive_tab = {
        bg_color = 'black',
        fg_color = 'yellow'
      },
      new_tab = {
        bg_color = 'black',
        fg_color = 'yellow'
      }
    }
  },
  default_cursor_style = 'SteadyBar',
  font = wezterm.font 'JetBrains Mono',
  font_size = 14,
  hide_tab_bar_if_only_one_tab = true,
  line_height = 1.05,
  show_tab_index_in_tab_bar = false,
  switch_to_last_active_tab_when_closing_tab = true,
  tab_bar_at_bottom = true,
  window_close_confirmation = 'NeverPrompt',
  window_frame = {
    active_titlebar_bg = 'black',
    font_size = 10
  },
  window_padding = {
    left = 30,
    right = 30,
    top = 30,
    bottom = 30
  }
}
