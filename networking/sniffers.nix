{ config, lib, pkgs, ... }: with lib;
let
  inherit (config.fnctl2) enable gui networking;
  hasGui = config.services.xserver.enable;


in {
  config = mkIf (enable && networking.enableSniffing) {

    environment.systemPackages = with pkgs; [
      tcpdump tshark wireshark-cli
    ];

    users.groups.pcap.gid = 2602;

    /* Allow execution of wireshark/dumpcap without password. */
    # security.wrappers.dumpcap = {
    #   source = "${pkgs.wireshark-cli}/bin/dumpcap";
    #   permissions = "u+xs,g+x";
    #   owner = "root";
    #   group = "pcap";
    # };

  };
}
