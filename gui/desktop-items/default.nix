{ config, pkgs, lib, ... }: with lib;
{ imports = [
  ./io.fnctl.nix
  ./gnvim.nix
  ./com.torn.nix
]; }
