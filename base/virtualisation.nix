{ config, lib, pkgs, ... }:
{

  config = lib.mkIf config.fnctl2.enable {
  /* Enable NixOS declarative containers. */
  boot.enableContainers = true;

  /* Enable KVM Intel Integration. */
  boot.kernelModules       = [ "kvm" "kvm-intel" ];

  /* Pass host's resolv conf to NixOS-containers. */
  networking.useHostResolvConf = true;

  virtualisation    = {
    libvirtd.enable = false;
    docker.enable   = true;
  };

  services.dockerRegistry = {
    enable = true;
    enableDelete = true;
    enableGarbageCollect = true;
    port = 5000;
    listenAddress = "127.0.0.1";
  };
};

}
