{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable dev;

in { config = mkIf (enable && dev.enable && dev.rust.enable) {
  environment.systemPackages = (with pkgs; [
    cargo     # Downloads Rust project dependencies and build projects
    rustup    # Rust toolchain installer
  ]);
}; }