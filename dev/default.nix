{ config, lib, options, pkgs, ... }: {

  imports = [
    ./docker.nix
    ./kubernetes.nix
    ./packages.nix
  # ./python.nix
    ./rust.nix
    ./terraform.nix
    ./vm.nix
  ];
}
