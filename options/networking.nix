{ config, lib, options, pkgs, ... }: 
{ options.fnctl2.networking = with lib; {

  tunePerformance = mkEnableOption "Tune networking stack for performance.";
  enableSniffing = mkEnableOption "Install network sniffing tools like tcpdump.";

}; }
