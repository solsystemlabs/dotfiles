-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = 'OneDark (Gogh)'

config.color_scheme = 'Gruvbox Dark (Gogh)'

config.keys = {
  -- Disable tab management keybindings
  { key = 'T',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = 'T',          mods = 'CTRL|SHIFT',     action = wezterm.action.DisableDefaultAssignment },
  { key = 'W',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = 'W',          mods = 'CTRL|SHIFT',     action = wezterm.action.DisableDefaultAssignment },
  { key = '1',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = '2',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = '3',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = '4',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = '5',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = '6',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = '7',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = '8',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = '9',          mods = 'SUPER',          action = wezterm.action.DisableDefaultAssignment },
  { key = 'Tab',        mods = 'CTRL',           action = wezterm.action.DisableDefaultAssignment },
  { key = 'PageDown',   mods = 'CTRL',           action = wezterm.action.DisableDefaultAssignment },
  { key = 'PageUp',     mods = 'CTRL',           action = wezterm.action.DisableDefaultAssignment },
  { key = 'O',          mods = 'ALT|SUPER',      action = wezterm.action.DisableDefaultAssignment },
  { key = 'UpArrow',    mods = 'ALT|SUPER',      action = wezterm.action.DisableDefaultAssignment },
  { key = 'DownArrow',  mods = 'ALT|SUPER',      action = wezterm.action.DisableDefaultAssignment },
  { key = 'LeftArrow',  mods = 'ALT|SUPER',      action = wezterm.action.DisableDefaultAssignment },
  { key = 'RightArrow', mods = 'ALT|SUPER',      action = wezterm.action.DisableDefaultAssignment },

  -- Disable pane splitting keybindings
  { key = '%',          mods = 'CTRL|SHIFT|ALT', action = wezterm.action.DisableDefaultAssignment },
  { key = '"',          mods = 'CTRL|SHIFT|ALT', action = wezterm.action.DisableDefaultAssignment },
}

config.enable_tab_bar = false
-- config.use_fancy_tab_bar = false
-- config.tab_bar_at_bottom = true
config.window_background_opacity = 0.85
config.macos_window_background_blur = 80

-- and finally, return the configuration to wezterm
return config
