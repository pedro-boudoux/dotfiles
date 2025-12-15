{config, pkgs, ...}:

{
  programs.kitty = {
    enable = true;

    font = {
      #name = "CommitMono Nerd Font";
      name = "Google Sans Code";
      size = 12;
    };

    settings = {
      enable_audio_bell = "no";
      scrollback_lines = 10000;
      background_blur = 5;
#      window_padding_width = 10;
      confirm_os_window_close = 0;
    };

    extraConfig = ''
    	include dank-theme.conf
    '';

  };
}
