{ config, lib, pkgs, ... }:
{
  sound.enable = lib.mkDefault true;

  hardware = {
    # Enable all the firmware with a license allowing
    # redistribution. (i.e. free firmware and firmware-linux-nonfree)
    enableRedistributableFirmware  = lib.mkDefault true;

    # Enable sound.
    pulseaudio.enable = lib.mkDefault true;

    # Enable bluetooth.
    bluetooth.enable = lib.mkDefault true;

    # Enable udev rules for Steam hardware such as the Steam Controller,
    # other supported controllers and the HTC Vive
    steam-hardware.enable = lib.mkDefault true;
  };
}