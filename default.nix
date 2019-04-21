{ nixos   ? (import <nixpkgs/nixos> {})
, config  ? nixos.config
, options ? nixos.options
, pkgs    ? nixos.pkgs
, lib     ? pkgs.lib
, ... }: { imports = [
    # clone the fnctl functions repo to this repo's parent directory
    ../functions/nixos.nix

    ./options
    ./base
    ./gui
    ./networking
    ./programs

]; }
