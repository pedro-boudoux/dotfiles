{ pkgs, inputs, ... }: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.niri.homeModules.niri
    inputs.dms-plugin-registry.modules.default
    ./kitty.nix
    ./swww.nix
    ./wofi.nix
    ./mako
    ./starship
    ./fish
    ./matugen
    ./nvf
    ./tmux
    ./appflowy
    ./firefox.nix
    # ./waybar # was commented out in original
  ];

  home.username = "pedro";
  home.homeDirectory = "/home/pedro";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    whitesur-gtk-theme
    papirus-icon-theme
    bibata-cursors
    qt6Packages.qt6ct
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
      Environment = [
        "QT_QPA_PLATFORMTHEME=qt6ct"
        "QS_ICON_THEME=Papirus-Dark"
        "XCURSOR_THEME=Bibata-Modern-Ice"
        "XCURSOR_SIZE=24"
      ];
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  # Authenticator autostart service
  systemd.user.services.authenticator = {
    Unit = {
      Description = "Authenticator";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.authenticator}/bin/authenticator";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  # Notification script for new TOTP codes
  home.file.".local/bin/authenticator-notify" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Monitor Authenticator for new codes and send notifications
      
      while true; do
        # Check if authenticator is running
        if pgrep -x "authenticator" > /dev/null; then
          # Use dbus to monitor for code changes (if available)
          # Or check every 30 seconds and notify when codes refresh
          sleep 30
          
          # Send notification through mako
          notify-send -a "Authenticator" -i "dialog-password" "New TOTP Codes Available" "Your 2FA codes have been refreshed"
        else
          sleep 5
        fi
      done
    '';
  };

  # Autostart the notification monitor
  systemd.user.services.authenticator-notify = {
    Unit = {
      Description = "Authenticator Notification Monitor";
      After = ["authenticator.service"];
      PartOf = ["authenticator.service"];
    };
    Service = {
      ExecStart = "%h/.local/bin/authenticator-notify";
      Restart = "always";
    };
    Install.WantedBy = ["authenticator.service"];
  };

  # FIXED: relative paths. this makes it portable.
  home.file = {
    ".config/niri/config.kdl".source = ./niri/config.kdl;
    ".config/waybar/style.css".source = ./waybar/style.css;
    # Copy instead of symlink so DankMaterialShell can modify these files at runtime
    ".config/DankMaterialShell/settings.json" = {
      source = ./dank-material-shell/settings.json;
      force = true;
    };
    ".config/DankMaterialShell/themes/gruvbox-material.json" = {
      source = ./dank-material-shell/gruvbox-material.json;
      force = true;
    };
    ".config/DankMaterialShell/themes/whitesur.json" = {
      source = ./dank-material-shell/whitesur.json;
      force = true;
    };
    # Link Papirus icon theme and Bibata cursor for DMS
    ".icons/Papirus-Dark".source = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";
    ".icons/Bibata-Modern-Ice".source = "${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Ice";
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
    theme = { package = pkgs.whitesur-gtk-theme; name = "WhiteSur-Dark"; };
    iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus-Dark"; };
    cursorTheme = { name = "Bibata-Modern-Ice"; package = pkgs.bibata-cursors; };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".force = true;
  xdg.configFile."gtk-4.0/settings.ini".force = true;

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
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

  # Prevent DankMaterialShell from overriding GNOME settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      text-scaling-factor = 1.1;  # 110% UI scale
      font-name = "Work Sans 11";  # Adjust to your preferred font
      document-font-name = "Work Sans 11";
      monospace-font-name = "Monaspace Neon 10";
    };
    "org/gnome/system/location" = {
      enabled = true;  # Set to false if you don't want location
    };
  };

  # Qt6ct configuration for DMS icon theming
  xdg.configFile."qt6ct/qt6ct.conf" = {
    force = true;
    text = ''
      [Appearance]
      icon_theme=Papirus-Dark
      
      [Fonts]
      general=Work Sans,11,-1,5,50,0,0,0,0,0
      fixed=Monaspace Neon,10,-1,5,50,0,0,0,0,0
    '';
  };

  # Environment variables for Qt theming
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QS_ICON_THEME = "Papirus-Dark";
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };
}
