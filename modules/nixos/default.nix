{ pkgs, inputs, ... }: {
  imports = [
    ./packages.nix
    ./fonts.nix
  ];

  # core generic settings
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; 

  # time & space
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";

  # networking basics
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  services.openssh.enable = true;
  services.mullvad-vpn.enable = true;

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig.pipewire."99-silent-bell.conf" = {
      "context.properties"."module.x11.bell" = false;
    };
  };

  # user land
  users.users.pedro = {
    isNormalUser = true;
    description = "pedro";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" "docker" ];
    shell = pkgs.fish;
  };

  # programs & services
  programs.fish.enable = true;
  programs.thunderbird.enable = true;
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };
  
  # virtualization
  programs.virt-manager.enable = true;
  virtualisation.libvirtd.enable = true;
  virtualisation.docker.enable = true;

  # graphical shell (niri)
  programs.niri.enable = true;
  services.xserver.xkb = { layout = "us"; variant = ""; };
  
  # Greeter (using greetd with tuigreet)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --cmd niri-session";
        user = "greeter";
      };
    };
  };
  
  services.getty.autologinUser = "pedro";

  # portals
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common.default = "*";
      niri = {
        default = [ "gnome" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      };
    };
  };
  systemd.user.services.xdg-desktop-portal.enable = true;
}
