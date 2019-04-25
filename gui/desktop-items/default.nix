{ config, pkgs, lib, ... }: with lib;
{ imports = [
  ./io.fnctl.nix
  ./com.torn.nix
]; }
