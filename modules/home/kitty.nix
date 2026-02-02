{config, pkgs, ...}:

{
  programs.kitty = {
    enable = true;

    font = {
      name = "MonaspiceNe Nerd Font Mono";
      size = 12;
    };

    settings = {
      enable_audio_bell = "no";
      scrollback_lines = 10000;
      background_blur = 5;
      confirm_os_window_close = 0;
      font_features = "MonaspiceNeNFM-Regular +calt +ss01 +ss02 +ss03 +ss04 +ss05 +ss06 +ss07 +ss08 +ss09 +ss10 +liga";

      # Enable remote control for dynamic padding changes
      allow_remote_control = "yes";
      listen_on = "unix:/tmp/kitty";
      
      # Default padding for terminal
      window_padding_width = "10";

      # Gruvbox Dark Medium colors
      foreground = "#d5c4a1";
      background = "#282828";
      selection_foreground = "#282828";
      selection_background = "#d5c4a1";
      cursor = "#d5c4a1";
      cursor_text_color = "#282828";
      url_color = "#7daea3";

      # Black
      color0 = "#282828";
      color8 = "#928374";

      # Red
      color1 = "#ea6962";
      color9 = "#ea6962";

      # Green
      color2 = "#a9b665";
      color10 = "#a9b665";

      # Yellow
      color3 = "#d8a657";
      color11 = "#d8a657";

      # Blue
      color4 = "#7daea3";
      color12 = "#7daea3";

      # Magenta
      color5 = "#d3869b";
      color13 = "#d3869b";

      # Cyan
      color6 = "#89b482";
      color14 = "#89b482";

      # White
      color7 = "#d5c4a1";
      color15 = "#fbf1c7";
    };

  };
}
