{ pkgs, inputs, ... }:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (pkgs.lib.getName pkg) [
    "spotify"
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.dribbblish;
    customColorScheme = {
      # Gruvbox Dark colors
      main = "#282828";
      text = "#ebdbb2";
      subtext = "#a89984";
      sidebar-text = "#ebdbb2";
      player = "#1d2021";
      card = "#282828";
      shadow = "#1d2021";
      selected-row = "#3c3836";
      button = "#fabd2f";
      button-active = "#fe8019";
      button-disabled = "#928374";
      tab-active = "#ebdbb2";
      notification = "#fe8019";
      "notification-error" = "#cc241d";
      misc = "#928374";
    };
    enabledExtensions = with spicePkgs.extensions; [
      hidePodcasts
      shuffle
    ];
  };
}
