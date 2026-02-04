{ pkgs, ... }:

{
  xdg.configFile."Antigravity/settings.json".source = ./antigravity/settings.json;
}
