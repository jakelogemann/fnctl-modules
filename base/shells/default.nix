{ config, pkgs, lib, ... }: {
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ]; 
}



