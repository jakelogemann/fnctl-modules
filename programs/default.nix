{ config, lib, options, pkgs, ... }: {
  imports = [

    ./git.nix
    ./tmux.nix
    ./fish.nix

  ];
}
