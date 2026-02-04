{ pkgs, ... }:

{
  xdg.configFile."Antigravity/settings.json".source = ./antigravity/settings.json;
  xdg.configFile."Antigravity/settings.json".force = true;
}
