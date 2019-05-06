{ config, lib, pkgs, ... }: with lib;
{ imports = [
  ./gnome
  ./desktop-items

  ./extra-services.nix
  ./fonts.nix
  ./xdg-mimetypes.nix
  ./packages.nix
  ./xserver.nix

]; }

