{ config, lib, pkgs, ... }: with lib;
{ config = mkIf config.fnctl2.enable {
  # Enable all the firmware with a license allowing
  # redistribution. (i.e. free firmware and firmware-linux-nonfree)
  hardware.enableRedistributableFirmware  = mkDefault true;

  # Enable sound.
  sound.enable                            = mkDefault true;
  hardware.pulseaudio.enable              = mkDefault true;

  # Enable bluetooth.
  hardware.bluetooth.enable               = mkDefault true;

  # Temporary files used by FnCtl. Root owned, never written to disk.
  fileSystems."/run/fnctl" = {
    fsType = "ramfs";
    options = [ "nosuid" "nodev" "mode=755" "gid=0" "uid=0" "size=1m" "nodiratime" ];
  };

  fileSystems."/vol" = {
    fsType = "ramfs";
    options = [ "nosuid" "nodev" "mode=0755" "gid=0" "uid=0" "size=1m" "nodiratime" ];
  };

}; }
