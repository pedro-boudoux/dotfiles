{ pkgs, ... }:

let
  wallpaperDir = ./dotfiles/wallpapers;  # relative path
  wallpapers = builtins.attrValues (builtins.readDir wallpaperDir);
  wallpaperPaths = map (f: "${wallpaperDir}/${f}") wallpapers;
in
{
  home.packages = with pkgs; [
    feh
    coreutils
    swww
  ];

  services.swww.enable = true;

  home.file.".local/bin/switch-wallpaper" = {
    text = ''

    '';
    executable = true;
  };
}
