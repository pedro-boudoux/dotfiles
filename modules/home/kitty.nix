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
#      window_padding_width = 10;
      confirm_os_window_close = 0;
      font_features = "MonaspiceNeNFM-Regular +calt +ss01 +ss02 +ss03 +ss04 +ss05 +ss06 +ss07 +ss08 +ss09 +ss10 +liga";
    };

    extraConfig = ''
    	include dank-theme.conf
    '';

  };
}
