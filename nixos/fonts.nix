{config , pkgs, ... }:
{
  # Fonts
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      corefonts
      vista-fonts
      inter-nerdfont
      font-awesome
      nerd-fonts.martian-mono
      work-sans
      font-awesome
      nerd-fonts.tinos
    ];
}
