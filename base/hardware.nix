{ config, lib, pkgs, ... }:
{
  # Enable all the firmware with a license allowing
  # redistribution. (i.e. free firmware and firmware-linux-nonfree)
  hardware.enableRedistributableFirmware  = lib.mkDefault true;

  # Enable sound.
  sound.enable                            = lib.mkDefault true;
  hardware.pulseaudio.enable              = lib.mkDefault true;

  # Enable bluetooth.
  hardware.bluetooth.enable               = lib.mkDefault true;
}