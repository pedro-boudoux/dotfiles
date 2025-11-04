{ config, pkgs, lib, home-manager, ... }:

let
  modulesDir = ./modules;
  niriConfigPath = ../niri/config.kdl;
  in
{
  home.username = "pedro";
  home.homeDirectory = "/home/pedro";
  home.stateVersion = "25.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    niri
    orchis-theme
    papirus-icon-theme
    bibata-cursors
    mako
  ];

  imports = [
    "${modulesDir}/kitty.nix"
     "${modulesDir}/swww.nix"
     "${modulesDir}/wofi.nix"
     "${modulesDir}/zed.nix"
     "${modulesDir}/waybar"
     "${modulesDir}/mako"
   ];

   home.file = {
     ".config/niri/config.kdl".source = "/home/pedro/dotfiles/niri/config.kdl";
     ".config/waybar/style.css".source = "/home/pedro/dotfiles/home-manager/modules/waybar/style.css";
   };


  home.sessionVariables = {
    # placeholder
  };

  programs.waybar.enable = true;
  programs.home-manager.enable = true;


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
}
