{
  pkgs,
  inputs,
  ...
}: let
  modulesDir = ./modules;
in {
  home.username = "pedro";
  home.homeDirectory = "/home/pedro";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    #niri
    orchis-theme
    papirus-icon-theme
    bibata-cursors
    mako
    #    gnome-keyring
    starship
    fish
    spicetify-cli
    matugen
    nil
    alejandra
  ];

  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.niri.homeModules.niri
    #    inputs.nvf.homeManagerModules.default
    "${modulesDir}/kitty.nix"
    "${modulesDir}/swww.nix"
    "${modulesDir}/wofi.nix"
    #"${modulesDir}/waybar"
    "${modulesDir}/mako"
    "${modulesDir}/starship"
    "${modulesDir}/fish"
    "${modulesDir}/matugen"
    "${modulesDir}/nvf"
    #"${modulesDir}/nvim"
  ];

  #programs.niri = {
  #  enable = true;
  #};

  programs.dankMaterialShell = {
    enable = true;
    # niri.enableKeybinds = true;
    # niri.enableSpawn = true;
  };

  systemd.user.services.dank-material-shell = {
    Unit = {
      Description = "Dank Material Shell";
      # vital: waits for the graphical session (niri) to be ready
      After = ["graphical-session.target"];
      PartOf = ["graphical-session.target"];
    };

    Service = {
      # use the direct path from the input so it never misses
      # assumes 'inputs' is passed to your home-manager args
      ExecStart = "${inputs.dankMaterialShell.packages.${pkgs.system}.default}/bin/dms run";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };

  home.file = {
    ".config/niri/config.kdl".source = "/home/pedro/dotfiles/home-manager/modules/niri/config.kdl";
    ".config/waybar/style.css".source = "/home/pedro/dotfiles/home-manager/modules/waybar/style.css";
  };

  home.sessionVariables = {
    # placeholder
  };

  #programs.waybar.enable = true;
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

    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Dark";
    };

    iconTheme = {
      package = pkgs.papirus-icon-theme;
      name = "Papirus";
    };

    cursorTheme = {
      name = "Bibata-Modern-Ice";
      package = pkgs.bibata-cursors;
    };
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
