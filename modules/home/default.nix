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
    # ./waybar # was commented out in original
  ];

  home.username = "pedro";
  home.homeDirectory = "/home/pedro";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    orchis-theme
    papirus-icon-theme
    bibata-cursors
    mako
    starship
    fish
    spicetify-cli
    matugen
    nil
    alejandra
  ];

  programs.dankMaterialShell.enable = true;

  systemd.user.services.dank-material-shell = {
    Unit = {
      Description = "Dank Material Shell";
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${inputs.dankMaterialShell.packages.${pkgs.system}.default}/bin/dms run";
      Restart = "on-failure";
      RestartSec = 5;
    };
    Install.WantedBy = ["graphical-session.target"];
  };

  # FIXED: relative paths. this makes it portable.
  home.file = {
    ".config/niri/config.kdl".source = ./niri/config.kdl;
    ".config/waybar/style.css".source = ./waybar/style.css;
  };

  programs.home-manager.enable = true;

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Tinos Nerd Font"];
      sansSerif = ["Work Sans"];
      monospace = ["MartianMono Nerd Font Mono"];
    };
  };

  gtk = {
    enable = true;
    theme = { package = pkgs.orchis-theme; name = "Orchis-Dark"; };
    iconTheme = { package = pkgs.papirus-icon-theme; name = "Papirus"; };
    cursorTheme = { name = "Bibata-Modern-Ice"; package = pkgs.bibata-cursors; };
  };

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
}
