{ config, lib, options, pkgs, ... }:

lib.mkIf config.fnctl2.enable {

  programs.bash = {
    enableCompletion = lib.mkDefault true;
  };

  environment.systemPackages = with pkgs; [
    cacert
  # kexec-tools         # Tools related to the kexec Linux feature
    # android-udev-rules  # Allows android MTP devices to be connected.
    # logitech-udev-rules # Allows Logitech devices to be (properly) connected.
  ];
}
