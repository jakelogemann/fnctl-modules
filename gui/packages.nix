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
    arandr            # visual frontend for XRandR, monitor configuration tool

    /* Standard X Desktop Utils */
    unstable.appeditor         /* Allows editing XDG Menu Items */
    xdg_utils
    xdg-user-dirs
    slock
    desktop-file-utils
    xsel
    xclip
    glxinfo       /* OpenGL X11 Info tool */
    xdo
    xdotool
    wmctrl

    /* Rofi & Friends */
    dmenu             # Highly configurable menu
    rofi              # Window switcher, app launcher, and dmenu replacement
    rofi-menugen      # Generates menu based applications using rofi
    rofi-pass         # A script to make rofi work with password-store
    rofi-systemd      # Control your systemd units using rofi

    /* Terminal Emulator(s)
    * TODO: This should be parameterized. */
    kitty             # Highly configurable terminal emulator
    alacritty     /* Modern, minimal & rust */

    /* Mail Reader(s)
    * TODO: This should be parameterized. */
    thunderbird       # Mail and calendar application

    /* Instant Messaging Client(s)
    * TODO: This should be parameterized. */
    (pidgin-with-plugins.override {
      plugins = [
        purple-plugin-pack
        purple-hangouts
        pidgin-otr
        pidgin-window-merge
      ];
    })
    slack
    signal-desktop

    /* Readers & Web Browser(s)
    TODO: This should be parameterized. */
    firefox    /* <3 Mozilla <3 */
    chromium   /* Google-free web browser */
    zeal         /* Docs Viewer (a la Dash on OS X). */
    liferea      /* RSS/Atom News Reader */

    /* Peer to Peer Client(s)
    TODO: This should be parameterized. */
    deluge

    /* Security related things...
    TODO: This should be parameterized. */
    yubikey-personalization-gui
    yubikey-manager-qt
    nmap-graphical    /* nmap GTK GUI */

    /* Office Productivity Suite(s)
    TODO: This should be parameterized. */
    libreoffice-fresh
    dia   # Diagram tool

    /* Design Suite(s)
    TODO: This should be parameterized. */
    gimp
    blender
    inkscape

   /* Backup / Sync Tools
    TODO: This should be parameterized. */
    deja-dup

   /* EXPERIMENTAL
    NOTE: These tools can be safely removed. They're not coupled to anything
          yet.
    TODO: This should be parameterized. */
    aesop     /* Elementary-style PDF Viewer. */
    bookworm  /* Elementary-style Ebook reader. */

  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

}; }
