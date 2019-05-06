{ config, lib, options, pkgs, ... }: {

  imports = [
    ./dns.nix
    ./firewall.nix
    ./nat.nix
    ./sniffers.nix
    ./sysctl.nix
  ];

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
    tcpdump         # Network sniffer
    wirelesstools   # tools to manipulate wireless extensions
    wireguard-tools # Tools for WireGuard secure network tunnel
  ]);
}
