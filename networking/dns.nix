{ config, lib, pkgs, ... }: with lib;

let
  isEnabled = (with config.fnctl2; enable);

in { config = lib.mkIf isEnabled {
  networking = {
    # Set default domain / hostname.
    domain = mkDefault "lan";
    hostName = mkDefault "Fnctl-OS";

    ## IPv6 Network Configuration.
    enableIPv6 = mkDefault false;

    # Recent versions of glibc will issue both ipv4 (A) and ipv6 (AAAA) address
    # queries at the same time, from the same port. Sometimes upstream routers
    # will systemically drop the ipv4 queries. The symptom of this problem is
    # that 'getent hosts example.com' only returns ipv6 (or perhaps only ipv4)
    # addresses. The workaround for this is to specify the option
    # 'single-request' in /etc/resolv.conf. This option enables that.
    dnsSingleRequest = mkDefault true;

  };
}; }

