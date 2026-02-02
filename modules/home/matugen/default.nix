{config, lib, ...}:
{
  xdg.configFile."matugen/templates/kitty.conf".text = ''
    cursor {{surfaceText}}
    foreground {{surfaceText}}
    background {{surface}}
    color0 {{surface}}
    color1 {{error}}
    color2 {{primary}}
    color3 {{secondary}}
    color4 {{primary}}
    color5 {{primaryContainer}}
    color6 {{surfaceContainer}}
    color7 {{surfaceText}}
    color8 {{surfaceVariant}}
    color9 {{error}}
    color10 {{primary}}
    color11 {{secondary}}
    color12 {{primary}}
    color13 {{primaryContainer}}
    color14 {{surfaceContainer}}
    color15 {{surfaceText}}
  '';

  # 2. define the main config that dms will unknowingly use
  xdg.configFile."matugen/config.toml".text = ''
    [config]
    reload_on_change = true

    [templates.kitty]
    input_path = "${config.xdg.configHome}/matugen/templates/kitty.conf"
    output_path = "${config.xdg.configHome}/kitty/dank-theme.conf"
    post_hook = "killall -USR1 kitty"

    [templates.spotify]
    input_path = "${config.xdg.configHome}/matugen/templates/spotify.ini"
    output_path = "${config.xdg.configHome}/spicetify/Themes/Matugen/color.ini"
    post_hook = "spicetify apply -n"

    [templates.nvim]
    input_path = "${config.xdg.configHome}/matugen/templates/nvim-theme.lua"
    output_path = "${config.xdg.configHome}/nvim/lua/matugen_theme.lua"
    post_hook = "echo 'Nvim theme generated'"

  '';

xdg.configFile."matugen/templates/spotify.ini".text = ''
    [Base]
    text               = {{colors.on_surface.default.hex_stripped}}
    subtext            = {{colors.on_surface_variant.default.hex_stripped}}
    nav-active-text    = {{colors.on_surface.default.hex_stripped}}
    main               = {{colors.surface.default.hex_stripped}}
    sidebar            = {{colors.surface_container.default.hex_stripped}}
    player             = {{colors.surface_container_high.default.hex_stripped}}
    card               = {{colors.surface_container_low.default.hex_stripped}}
    shadow             = {{colors.shadow.default.hex_stripped}}
    selected-row       = {{colors.surface_container_highest.default.hex_stripped}}
    button             = {{colors.primary.default.hex_stripped}}
    button-active      = {{colors.primary.default.hex_stripped}}
    button-disabled    = {{colors.on_surface.default.hex_stripped}}
    tab-active         = {{colors.surface_container_highest.default.hex_stripped}}
    notification       = {{colors.error.default.hex_stripped}}
    notification-error = {{colors.error.default.hex_stripped}}
    misc               = {{colors.outline.default.hex_stripped}}
  '';

xdg.configFile."matugen/templates/nvim-theme.lua".text = ''
  local colors = {
    normal = "{{colors.surface.default.hex}}",
    fg = "{{colors.on_surface.default.hex}}",
    cursor_line = "{{colors.surface_container.default.hex}}",
    comment = "{{colors.on_surface_variant.default.hex}}",
    string = "{{colors.primary.default.hex}}",
    keyword = "{{colors.secondary.default.hex}}",
    func = "{{colors.tertiary.default.hex}}",
    error = "{{colors.error.default.hex}}",
    visual = "{{colors.secondary_container.default.hex}}",
  }

  local hl = vim.api.nvim_set_hl
  local opts = { noremap = true, silent = true }

  -- brute force override base colors
  hl(0, "Normal", { fg = colors.fg, bg = colors.normal })
  hl(0, "NormalFloat", { fg = colors.fg, bg = colors.normal })
  hl(0, "CursorLine", { bg = colors.cursor_line })
  hl(0, "LineNr", { fg = colors.comment })
  hl(0, "CursorLineNr", { fg = colors.string, bold = true })
  hl(0, "Visual", { bg = colors.visual })

  -- syntax overrides (simplified)
  hl(0, "Comment", { fg = colors.comment, italic = true })
  hl(0, "String", { fg = colors.string })
  hl(0, "Function", { fg = colors.func, bold = true })
  hl(0, "Keyword", { fg = colors.keyword, italic = true })
  hl(0, "Constant", { fg = colors.string })
  hl(0, "Type", { fg = colors.func })
  hl(0, "Error", { fg = colors.error })
  
  -- ui components (nvim-tree, telescope, etc)
  hl(0, "NvimTreeNormal", { fg = colors.fg, bg = colors.normal })
  hl(0, "TelescopeNormal", { fg = colors.fg, bg = colors.normal })
'';

}
