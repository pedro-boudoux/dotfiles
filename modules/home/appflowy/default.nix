{ config, pkgs, ... }: let
  gruvboxDark = builtins.readFile ./gruvbox-dark.json;
  gruvboxLight = builtins.readFile ./gruvbox-light.json;
in {
  # AppFlowy theme files
  # Themes are stored in ~/.local/share/appflowy/flowy_themes/
  # Using activation script to copy files (not symlink) for AppFlowy compatibility
  home.activation.appflowyThemes = config.lib.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD mkdir -p $HOME/.local/share/appflowy/flowy_themes/Gruvbox-Dark
    
    # Remove existing files (symlinks or regular files) before copying
    $DRY_RUN_CMD rm -f "$HOME/.local/share/appflowy/flowy_themes/Gruvbox-Dark/Gruvbox-Dark.dark.json"
    $DRY_RUN_CMD rm -f "$HOME/.local/share/appflowy/flowy_themes/Gruvbox-Dark/Gruvbox-Dark.light.json"
    
    $DRY_RUN_CMD cp ${pkgs.writeText "gruvbox-dark.json" gruvboxDark} $HOME/.local/share/appflowy/flowy_themes/Gruvbox-Dark/Gruvbox-Dark.dark.json
    $DRY_RUN_CMD cp ${pkgs.writeText "gruvbox-light.json" gruvboxLight} $HOME/.local/share/appflowy/flowy_themes/Gruvbox-Dark/Gruvbox-Dark.light.json
  '';
}
