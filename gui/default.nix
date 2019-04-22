{ config, lib, pkgs, ... }: 
{ imports = [

  ./extra-services.nix
  ./fonts.nix
  ./gnome-packages.nix
  ./gnome-services.nix
  ./gnome-dconf.nix
  ./gnome-app-items.nix
  ./gnome-app-folders.nix
  ./xdg-mimetypes.nix
  ./gnome.nix
  ./packages.nix
  ./xserver.nix

]; }

