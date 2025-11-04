{ config, pkgs, lib, ... }:

{
  # 1. Install Mako (Crucial for the program to run)
  home.packages = [ pkgs.mako ];

  # 2. Use home.file to generate the raw Mako config (Darcula Style)
  # This uses the correct Mako syntax to avoid the 'Failed to parse' error.
  home.file.".config/mako/config".text = ''
    sort=-time
    layer=overlay
    background-color=#202020
    width=450
    height=200
    icons=1
    border-radius=0
    border-size=0
    max-icon-size=64
    default-timeout=5000
    ignore-timeout=1
    padding=20
    font=Work Sans 14

    [urgency=low]
    border-color=#cccccc00

    [urgency=normal]
    border-color=#d08770

    [urgency=high]
    border-color=#bf616a
    default-timeout=0

    [category=mpd]
    default-timeout=2000
    group-by=category

  '';
}
