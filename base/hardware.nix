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

  # Enable udev rules for Steam hardware such as the Steam Controller,
  # other supported controllers and the HTC Vive
  hardware.steam-hardware.enable          = lib.mkDefault true;
}