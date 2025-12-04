{config, pkgs, ...}:

{
  programs.kitty = {
    enable = true;

    themeFile = "Jet Brains Darcula";

    font = {
      name = "MartianMono Nerd Font Mono";
      size = 12;
    };

    settings = {
      enable_audio_bell = "no";
      scrollback_lines = 10000;
      background_blur = 5;
      window_padding_width = 10;
      confirm_os_window_close = 0;
    };

  };
}
