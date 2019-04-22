{ config, lib, options, pkgs, ... }: {

  imports = [
    ./dns.nix
    ./firewall.nix
    ./nat.nix
    ./sniffers.nix
    ./sysctl.nix
  ];

}
