{ config, lib, pkgs, ... }: 
{ imports = [
  ./fonts.nix
  ./gnome.nix
  ./xserver.nix
  ./packages.nix
]; }

