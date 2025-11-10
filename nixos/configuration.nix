{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./packages.nix
      ./fonts.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot = {
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
      extraModprobeConfig = ''
        options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
      '';
      kernelParams = ["nvidia-drm.modeset=1"];
  };

  boot.initrd.availableKernelModules = [ "nvidia_uvm" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

 security.rtkit.enable = true;

 services.pipewire = {
    enable = true; # if not already enabled
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment the following
    #jack.enable = true;
    extraConfig = {
      pipewire."99-silent-bell.conf" = {
        "context.properties" = {
          "module.x11.bell" = false;
        };
      };
    };
  };

  hardware.graphics = {
  	enable = true;
  };
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
  	modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];

  };


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.ollama = {
    enable = true;
    acceleration = "cuda";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pedro = {
    isNormalUser = true;
    description = "pedro";
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [];
    shell = pkgs.fish;
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "pedro";
  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        #command = "env XDG_SESSION_TYPE=wayland dbus-run-session niri";
        command = "${pkgs.niri}/bin/niri-session";
        user = "pedro";
      };
    };
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget


  programs.obs-studio ={
    enable = true;
    package = (pkgs.obs-studio.override { cudaSupport = true; });
  };


  programs.thunderbird.enable = true;
  programs.fish.enable = true;

  programs.steam ={
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.niri = {
  	enable = true;
  };

programs.waybar = {
  enable = true;
};


programs.virt-manager.enable = true;
virtualisation.libvirtd.enable = true;

xdg.portal = {
  enable = true;
  # Keep gtk for file choosers, but prioritize wlr for screen/window operations
  extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-wlr
    # The gnome portal is likely unnecessary with niri/wlr/gtk
    # pkgs.xdg-desktop-portal-gnome
  ];
  config = {
    # Set the default for the common case to wlr
    # Many apps will use the default before looking at session-specific configs
    common.default = "wlr";

    niri = {
      # Fallback defaults for niri sessions
      default = [ "wlr" "gtk" ];
      # Explicitly use the wlr portal for screensharing and screenshots
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
    };
  };
};
systemd.user.services.xdg-desktop-portal.enable = true;



# Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
   services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
