{ pkgs, inputs, ... }: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.niri.homeModules.niri
    ./kitty.nix
    ./swww.nix
    ./wofi.nix
    ./mako
    ./starship
    ./fish
    ./matugen
    ./nvf
    ./tmux
    # ./waybar # was commented out in original
  ];

  home.username = "pedro";
  home.homeDirectory = "/home/pedro";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    orchis-theme
    papirus-icon-theme
    whitesur-cursors
    mako
    starship
    fish
    spicetify-cli
    matugen
    tmux
  ];

  programs.dankMaterialShell.enable = true;

  systemd.user.services.dank-material-shell = {
    Unit = {
      Description = "Dank Material Shell";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${inputs.dankMaterialShell.packages.${pkgs.stdenv.hostPlatform.system}.default}/bin/dms run";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  # FIXED: relative paths. this makes it portable.
  home.file = {
    ".config/niri/config.kdl".source = ./niri/config.kdl;
    ".config/waybar/style.css".source = ./waybar/style.css;
    ".config/DankMaterialShell/settings.json".source = ./dank-material-shell/settings.json;
  };

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    settings = {
      pull.rebase = false;
      user.name = "Pedro";
      user.email = "pboudoux@outlook.com";
      core.editor = "code";
      init.defaultBranch = "main";
      # merge.tool = "vimdiff";
      # diff.tool = "vimdiff";
      color.ui = true;
      # push.default = "simple";
      # pull.ff = "only";
      rebase.autoStash = true;
      credential.helper = "store";
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Tinos Nerd Font"];
      sansSerif = ["Work Sans"];
      monospace = ["Monaspace Neon"];
    };
  };

  gtk = {
    enable = true;
    theme = { package = pkgs.orchis-theme; name = "Orchis-Dark"; };
    iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus"; };
    cursorTheme = { name = "WhiteSur-cursors"; package = pkgs.whitesur-cursors; };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.whitesur-cursors;
    name = "WhiteSur-cursors";
    size = 24;
    gtk.enable = true;
  };

  services.gnome-keyring = {
    enable = true;
    components = ["secrets" "pkcs11" "ssh"];
  };

  xdg.portal.config.common = {
    "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = "firefox.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "x-scheme-handler/about" = "firefox.desktop";
      "x-scheme-handler/unknown" = "firefox.desktop";
      "application/pdf" = "okular.desktop";
    };
  };
}
