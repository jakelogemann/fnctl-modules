{ config, lib, options, pkgs, ... }:

{ options.fnctl2.dev = (with lib; {

  enable = mkEnableOption "Enable opinionated development environment.";

  ansible = {
    enable = mkEnableOption "Enable opinionated system-wide ansible development config.";
  };

  docker = {
    enable = mkEnableOption "Enable opinionated system-wide docker development config.";
  };

  go = {
    enable = mkEnableOption "Enable opinionated system-wide go development config.";
  };

  kubernetes = {
    enable = mkEnableOption "Enable opinionated system-wide kubernetes development config.";
  };

  python = {
    enable = mkEnableOption "Enable opinionated system-wide python development config.";
  };

  rust = {
    enable = mkEnableOption "Enable opinionated system-wide rust development config.";
  };

  terraform = {
    enable = mkEnableOption "Enable opinionated system-wide terraform development config.";
  };

  vm = {
    enable = mkEnableOption "Enable opinionated system-wide VM development config.";
  };
}); }
