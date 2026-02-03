{ config, pkgs, ... }: {
  # AppFlowy theme files
  # Themes are stored in ~/.local/share/appflowy/flowy_themes/
  # Using xdg.dataFile which creates actual files in ~/.local/share
  xdg.dataFile = {
    "appflowy/flowy_themes/Gruvbox-Dark/Gruvbox-Dark.dark.json".text = builtins.readFile ./gruvbox-dark.json;
    "appflowy/flowy_themes/Gruvbox-Dark/Gruvbox-Dark.light.json".text = builtins.readFile ./gruvbox-light.json;
  };
}
