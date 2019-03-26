{ nixos   ? (import <nixpkgs/nixos> {})
, config  ? nixos.config
, options ? nixos.options
, pkgs    ? nixos.pkgs
, lib     ? pkgs.lib
, ... }: { imports = [
    /home/jake/fnctl/nix/functions/nixos.nix

    ./options
    ./networking
    ./programs

]; }
