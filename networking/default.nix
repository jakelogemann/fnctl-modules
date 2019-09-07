{ config, lib, options, pkgs, ... }: with lib; 
let
  isEnabled = with config.fnctl2; enable;
in {

  imports = [
    ./firewall.nix
    ./nat.nix
    ./sniffers.nix
    ./sysctl.nix
  ];

  config = mkIf isEnabled {
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

    environment.systemPackages = (with pkgs; [
      curl            # A command line tool for transferring files with URL syntax
      openvpn         # A robust and highly flexible tunneling application
      rclone          # Command line program to sync files and directories to and from major cloud storage
      whois           # A client for the WHOIS protocol to query the owner of a domain name
      wget            # Tool for retrieving files using HTTP, HTTPS, and FTP
      rsync           # A fast incremental file transfer utility
      fping           # Send ICMP echo probes to network hosts
      netcat          # Free TLS/SSL implementation
      dnsutils        # Bind DNS Server
      iputils         # A set of small useful utilities for Linux networking
      nettools        # A set of tools for controlling the network subsystem in Linux
      wirelesstools   # tools to manipulate wireless extensions
      wireguard-tools # Tools for WireGuard secure network tunnel
    ]);
  };
}
