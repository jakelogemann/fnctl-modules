{ config, lib, options, pkgs, ... }:

lib.mkIf config.fnctl2.enable {

  environment.systemPackages = (with pkgs; [
    btrfsProgs  # btrfs fileystem tools
    cacert    # A bundle of X.509 certificates of public Certificate Authorities (CA)
    coreutils # The basic file, shell and text manipulation utilities of the GNU operating system
    findutils # GNU Find Utilities, the basic directory searching utilities of the GNU operating system
    gawk      # GNU implementation of the Awk programming language
    gnugrep   # GNU implementation of the Unix grep command
    gnused    # GNU sed, a batch stream editor
    gnutar    # GNU implementation of the `tar' archiver
    gparted   # Drive partitioning tool
    gzip      # GNU zip compression program
    hwinfo    # Hardware detection tool
    lshw      # Pretty, indented hardware info
    lsof      # A tool to list open files
    nix-du    # A tool to determine which gc-roots take space in your nix store
    openssl   # A cryptographic library that implements the SSL and TLS protocols
    pass      # Stores, retrieves, generates, and synchronizes passwords securely
    pciutils  # A collection of programs for inspecting and manipulating configuration of PCI devices
    pstree    # Shows processes
    ranger    # File system navigation tool
    readline  # Library for interactive line editing
    ripgrep   # Utility that combines the usability of The Silver Searcher with the speed of grep
    thefuck   # Magnificent app which corrects your previous console command
    tpm-tools # Trusted process module tools
    tree      # Command to produce a depth indented directory listing
    unzip     # An extraction utility for archives compressed in .zip format
    usbutils  # Tools for working with USB devices, such as lsusb
    which     # command to locate the executable file associated with the given command
  ]);
}
