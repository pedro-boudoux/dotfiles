{config, pkgs, ...}:
{
  programs.fish = {
    enable = true;
    shellAliases = {
      hms = "home-manager switch --flake \"/home/pedro/dotfiles/home-manager#pedro\" --impure";
      nrs = "sudo nixos-rebuild switch";
    };
  };
}
