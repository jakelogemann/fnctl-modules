{ config, lib, pkgs, ... }: 

let
  isEnabled = (with config.fnctl2; enable && networking.enableSniffing);

in { config = lib.mkIf isEnabled {

  environment.systemPackages = with pkgs; [
    tcpdump
    # wireshark-gtk  # FIXME: This probably **requires** X11.
  ];

  users.groups.pcap.gid = 2602;

  # Allow execution of wireshark/dumpcap without password.
  security.wrappers.dumpcap = {
    source = "${pkgs.wireshark-gtk}/bin/dumpcap";
    permissions = "u+xs,g+x";
    owner = "root";
    group = "pcap";
  };

}; }

