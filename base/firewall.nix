{ config, pkgs, lib, ... }:
let
  inherit (lib) concatStringsSep mkIf mkDefault;

  enabled = config.fnctl2.enable;

in {

  networking.firewall = mkIf enabled {

    enable = true;

    # Dynamically load conntrack helpers as they are used instead always
    # loading them all since this can be a security vulnerability.
    autoLoadConntrackHelpers = mkDefault true;

    # Only allow packets for which we know the reverse path of.
    checkReversePath = mkDefault true;

    # Reject instead of dropping (quicker, since its not publicly exposed this is okay.
    rejectPackets = mkDefault true;

    allowPing = mkDefault true;
    pingLimit = "--limit 10/minute --limit-burst 50";

    logRefusedConnections = true;
    logRefusedPackets     = true;
    logReversePathDrops   = true;

    allowedTCPPorts = [ 22 ];
    allowedUDPPorts = [
      9   # Wake-on-Lan
    ];
  };

}
