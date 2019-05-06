{ config, pkgs, lib, options, ... }: with lib;

let
  inherit (config.fnctl2) enable dev gui;

in { config = mkIf (enable && dev.enable && dev.vm.enable) {

  virtualisation = {
    virtualbox.host = {
      enable              = true;
      enableExtensionPack = true;
      enableHardening     = false;
      addNetworkInterface = true;
    };
  };

  environment.systemPackages = (with pkgs; [
    virtualbox         # Hypervisor for x86 virtualization
    kvm                # Kernel-based Virtual Machine
    vagrant            # tool for building complete dev environments
    virtmanager        # Desktop UI for managing virtual machines
    virtmanager-qt     # Desktop UI for managing virtual machines (QT)
  ]) ++ (optionals gui.enable (with pkgs; [
    gnome3.gnome-boxes # Simple app to access remote or virtual systems
  ]));

}; }
