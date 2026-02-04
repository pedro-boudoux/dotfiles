{ pkgs, lib, inputs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  # Import the spicetify home-manager module
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  # Configure spicetify with Gruvbox theme (onepunch)
  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.onepunch;
    
    # Useful extensions
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      hidePodcasts
      shuffle
    ];
  };
}
