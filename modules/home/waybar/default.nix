{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        spacing = 8;

        # Add cpu, memory explicitly here if you want them on the bar
        modules-left = ["niri/workspaces" "niri/window"];
        modules-center = ["clock"];
        modules-right = ["tray" "cpu" "memory" "network" "pulseaudio"];

        clock = {
          format = "{:%a %b %d %H:%M}";
          tooltip-format = "{:%A, %B %d %Y}";
          interval = 60;
        };

        cpu = {
          format = "  {usage}%";
          tooltip = true;
        };

        memory = {
          format = "  {used:0.1f} G / {total:0.1f} G";
          tooltip = true;
        };

        # Uncomment if you want battery module enabled
        # battery = {
        #   format = "{icon}  {capacity}%";
        #   format-icons = [ " " " " " " " " " " ];
        #   format-charging = "  {capacity}%";
        #   interval = 30;
        # };

        network = {
          format-wifi = "    {essid} ({signalStrength}%)";
          format-ethernet = "   {ipaddr}";
          format-disconnected = "Disconnected";
          tooltip = true;
        };

        pulseaudio = {
          scroll_step = 5;  # changed hyphen to underscore
          format = "{icon} {volume}% {format_source}";
          format_bluetooth = " {icon} {volume}% {format_source}";
          format_bluetooth_muted = "  {icon} {format_source}";
          format_muted = "  {format_source}";
          format_source = "  {volume}%";
          format_source_muted = "  ";
          format_icons = {
            default = ["  " "  " "  "];
            on-click-right = "foot -a pw-top pw-top";
            on-click = "pavucontrol";
          };
        };

        tray = {
          spacing = 10;
          icon_size = 21;
        };

      };
    };
  };
}
