{ ... }:

{
  xdg.configFile."Code/User/settings.json".source = ./vscode/settings.json;
  xdg.configFile."Code/User/settings.json".force = true;
}
