-- https://raw.githubusercontent.com/kovidgoyal/kitty-themes/master/template.conf
local template = [[
foreground $foreground
background $background
selection_foreground $selection_foreground
selection_background $selection_background
url_color $url_color
cursor $cursor
cursor_text_color $cursor_text_color

# Tabs
active_tab_background $active_tab_background
active_tab_foreground $active_tab_foreground
inactive_tab_background $inactive_tab_background
inactive_tab_foreground $inactive_tab_foreground
tab_bar_background $tab_bar_background
tab_bar_margin_color $tab_bar_margin_color

# Windows
active_border_color $active_border_color
inactive_border_color $inactive_border_color

# Normal
color0 $black
color8 $black
color1 $red
color9 $red
color2 $green
color10 $green
color3 $yellow
color11 $yellow
color4 $blue
color12 $blue
color5 $magenta
color13 $magenta
color6 $cyan
color14 $cyan
color7 $black
color15 $black

# Other
bell_border_color $bell_border_color
# wayland_titlebar_color $wayland_titlebar_color
# macos_titlebar_color $macos_titlebar_color
mark1_foreground $mark1_foreground
mark1_background $mark1_background
mark2_foreground $mark2_foreground
mark2_background $mark2_background
mark3_foreground $mark3_foreground
mark3_background $mark3_background
]]

return function(name)
  package.loaded["ah.plugins.lush.specs." .. name] = nil
  local spec = require("ah.plugins.lush.specs." .. name)
  local palette = spec.Palette.lush

  local value = vim.tbl_extend("error", palette, {
    -- Basic colors
    foreground = palette.black,
    background = palette.white,
    selection_background = spec.Visual.bg,
    -- URL underline color when hovering with mouse
    url_color = palette.magenta,
    -- Terminal window border colors and terminal bell colors
    active_border_color = spec.WinSeparator.bg,
    inactive_border_color = spec.WinSeparator.bg,
    -- Tab bar colors
    active_tab_foreground = spec.TabLineSel.fg,
    active_tab_background = spec.TabLineSel.bg,
    inactive_tab_foreground = spec.TabLine.fg,
    inactive_tab_background = spec.TabLine.bg,
    tab_bar_background = spec.TabLineFill.bg,
  })

  -- Cast colors to their hex representation
  for name, color in pairs(value) do
    value[name] = tostring(color)
  end

  -- Substitute colors in the template
  local text = string.gsub(template, "$([%w%d_]+)", value)

  -- Open file for writing
  local fd, e = io.open(os.getenv('XDG_CONFIG_HOME') .. "/kitty/themes/" .. name .. ".conf", "w")
  assert(fd, e)

  -- Only write lines that do not contain $ since kitty complains about them
  for line in vim.gsplit(text, "\n") do
    if not string.match(line, "%$") then
      fd:write(line .. "\n")
    end
  end

  -- Close file handle
  fd:close()
end
