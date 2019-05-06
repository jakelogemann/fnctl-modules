{ config, pkgs, lib, ... }: with lib;
let
  inherit (config.fnctl2) enable gui;
in { config = mkIf (enable && gui.enable) {

  nixpkgs.config = {
    allowUnfree        = true;
    packageOverrides   = pkgs: {
       unstable        = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {
         config        = config.nixpkgs.config;
      };
    };
  };

  environment.variables."TERM"          = mkForce gui.defaultApps.terminal;
  environment.sessionVariables."TERM"   = gui.defaultApps.terminal;

  environment.systemPackages = with pkgs; [
    arandr             # visual frontend for XRandR, monitor configuration tool

    /* Standard X Desktop Utils */
    unstable.appeditor # Allows editing XDG Menu Items
    xdg_utils          # A set of command line tools that assist applications with a variety of desktop integration tasks
    xdg-user-dirs      # A tool to help manage well known user directories like the desktop folder and the music folder
    slock              # Simple X display locker
    desktop-file-utils # Command line utilities for working with .desktop files
    xsel               # Command-line program for getting and setting the contents of the X selection
    xclip              # Tool to access the X clipboard form a console application
    glxinfo            # OpenGL X11 Info tool
    xdo                # Small X utility to perform elementary actions on windows
    xdotool            # Fake keyboard/mouse input, window management, and more
    wmctrl             # Command line tool to interact with an EWMH/NetWM compatible X Window Manager
    htop               # better than top for process introspection and manipulation
    redshift           # Blue light filter

    /* Rofi & Friends */
    dmenu              # Highly configurable menu
    rofi               # Window switcher, app launcher, and dmenu replacement
    rofi-menugen       # Generates menu based applications using rofi
    rofi-pass          # A script to make rofi work with password-store
    rofi-systemd       # Control your systemd units using rofi

    /* Terminal Emulator(s)
    * TODO: This should be parameterized. */
    kitty              # Highly configurable terminal emulator
    alacritty          # Modern, minimal & rust

    /* Mail Reader(s)
    * TODO: This should be parameterized. */
    thunderbird        # Mail and calendar application

    /* Instant Messaging Client(s)
    * TODO: This should be parameterized. */
    (pidgin-with-plugins.override { # Multi-protocol instant messaging client
      plugins = [
        purple-plugin-pack   # Plugin pack for Pidgin 2.x
        purple-hangouts      # Native Hangouts support for pidgin
        pidgin-otr           # Plugin for Pidgin 2.x which implements OTR Messaging
        pidgin-window-merge  # Pidgin plugin that merges the Buddy List window with a conversation window
      ];
    })
    slack                    # Chat application
    signal-desktop           # Private, simple, and sercure messenger

    /* Readers & Web Browser(s)
    TODO: This should be parameterized. */
    firefox                  # <3 Mozilla <3, interwebs browser
    chromium                 # Open source Chrome interwebs browser
    liferea                  # RSS/Atom News Reader */

    /* Peer to Peer Client(s)
    TODO: This should be parameterized. */
    deluge                   # Torrent client

    /* Security related things...
    TODO: This should be parameterized. */
    yubikey-personalization-gui # Facilitate reconfiguration of YubiKeys
    yubikey-manager-qt          # Configure YubiKeys over all USB interfaces
    yubico-piv-tool             # Interact with the Privilege and Identification Card app on a YubiKey
    nmap-graphical              # nmap GTK GUI

    /* Office Productivity Suite(s)
    TODO: This should be parameterized. */
    libreoffice-fresh     # Open Source Productivity Suite
    dia                   # Diagram tool

    /* Design Suite(s)
    TODO: This should be parameterized. */
    gimp                  # Advanced image editing tools
    blender               # 3D Creation/Animation/Publishing System
    inkscape              # Vector graphics editor

    /* Backup / Sync Tools
    TODO: This should be parameterized. */
    deja-dup              # Simple backup tool

    /* Networking */
    networkmanagerapplet  # NetworkManager control applet for GNOME
    wireshark-gtk         # Powerful network protocol analyzer

    /* EXPERIMENTAL
    NOTE: These tools can be safely removed. They're not coupled to anything
          yet.
    TODO: This should be parameterized. */
    aesop                 # Elementary-style PDF Viewer
    bookworm              # Elementary-style Ebook reader

  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

}; }
