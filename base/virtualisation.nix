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
      docker.enable   = false;
    };

    # Container Tools
    environment.systemPackages = with pkgs; [ 
      buildah   # OCI Image builder.
      podman    # OCI Container manager designed for k8s.
      skaffold  # Healthier alternative to Docker Compose.
    ];

    services.dockerRegistry = {
      enable = true;
      enableDelete = true;
      enableGarbageCollect = true;
      port = 5000;
      listenAddress = "127.0.0.1";
    };
  };

}
