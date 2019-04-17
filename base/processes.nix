{ config, lib, pkgs, ... }:
let
  inherit (lib) mkDefault mkIf mkBefore;

in {
  config = mkIf config.fnctl2.enable {

    powerManagement.cpuFreqGovernor = mkDefault "powersave";

    system.nixos.tags = mkBefore [ "fnctl" ];

    services.earlyoom = mkDefault {
      enable                 = true;
      # ignoreOOMScoreAdjust = true;
      useKernelOOMKiller     = true;

      # Thresholds (in percentages) at
      # which memory should be freed.
      freeMemThreshold       = 10;
      freeSwapThreshold      = 10;
    };

    # Automatically refills /dev/random with entropy.
    services.haveged.enable       = mkDefault true;
    services.tlp.enable           = mkDefault true;
    services.geoip-updater.enable = mkDefault true;

  };
}
