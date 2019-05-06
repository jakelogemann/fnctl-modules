{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable dev;

in { config = mkIf (enable && dev.enable && dev.terraform.enable) {
  # TODO: This may need to be an overlay to allow terraform.withPlugins
  environment.systemPackages = (with pkgs; [
    terraform       # Tool for building, changing, and versioning infrastructure
    terraform-docs  # A utility to generate documentation from Terraform modules in various output formats
  ]);
}; }