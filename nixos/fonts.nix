{config , pkgs, ... }:
{
  # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      corefonts
      vistafonts
      inter-nerdfont
      font-awesome
      nerd-fonts.martian-mono
      work-sans
      font-awesome
      nerd-fonts.tinos
    ];
}
