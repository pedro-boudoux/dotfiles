{
  config,
  pkgs,
  ...
}: {
  imports = [
    ../../modules/nixos/default.nix
    ./hardware-configuration.nix # ensure you moved this file here
  ];

  networking.hostName = "laptop";

  # bootloader specifics
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.dbus.enable = true;
  services.upower.enable = true;

  security.polkit.enable = true;

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # nvidia kernel hell
  #boot.kernelModules = [ "v4l2loopback" ];
  #boot.extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
  #boot.extraModprobeConfig = ''
  #  options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  #'';
  #boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  #boot.initrd.availableKernelModules = [ "nvidia_uvm" ];
  #boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # graphics drivers
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    # extraPackages = with pkgs; [ nvidia-vaapi-driver libvdpau-va-gl ];
  };
  #services.xserver.videoDrivers = [ "nvidia" ];

  #hardware.nvidia = {
  #  modesetting.enable = true;
  #  powerManagement.enable = false;
  #  powerManagement.finegrained = false;
  #  open = false;
  #  nvidiaSettings = true;
  #  package = config.boot.kernelPackages.nvidiaPackages.latest;
  #};

  # heavy metal apps (cuda/gaming)
  #services.ollama = {
  #   enable = true;
  #   acceleration = "cuda";
  # };

  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };
}
