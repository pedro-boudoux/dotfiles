{config, lib, ...}:
{
  xdg.configFile."matugen/templates/kitty.conf".text = ''
    cursor {{colors.on_surface.default.hex}}
    foreground {{colors.on_surface.default.hex}}
    background {{colors.surface.default.hex}}
    color0 {{colors.surface.default.hex}}
    color1 {{colors.error.default.hex}}
    color2 {{colors.primary.default.hex}}
    color3 {{colors.secondary.default.hex}}
    color4 {{colors.tertiary.default.hex}}
    color5 {{colors.primary_container.default.hex}}
    color6 {{colors.secondary_container.default.hex}}
    color7 {{colors.on_surface.default.hex}}
    color8 {{colors.surface_bright.default.hex}}
    color9 {{colors.error.default.hex}}
    color10 {{colors.primary.default.hex}}
    color11 {{colors.secondary.default.hex}}
    color12 {{colors.tertiary.default.hex}}
    color13 {{colors.primary_container.default.hex}}
    color14 {{colors.secondary_container.default.hex}}
    color15 {{colors.on_surface.default.hex}}
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
  '';
}
