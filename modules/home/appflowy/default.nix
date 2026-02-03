{ config, pkgs, ... }: {
  # AppFlowy theme files
  # Themes are stored in ~/.local/share/appflowy/flowy_themes/
  # and can be imported through the AppFlowy settings UI
  home.file = {
    ".local/share/appflowy/flowy_themes/Gruvbox-Dark/Gruvbox-Dark.dark.json" = {
      text = builtins.readFile ./gruvbox-dark.json;
      force = true;
    };
    
    ".local/share/appflowy/flowy_themes/Gruvbox-Dark/Gruvbox-Dark.light.json" = {
      text = builtins.readFile ./gruvbox-light.json;
      force = true;
    };
  };
}
