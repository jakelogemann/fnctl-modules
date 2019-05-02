{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable gui;

  gnomeExts = (with pkgs.gnomeExtensions; [
    appindicator        /* app icons in top bar */
    caffeine            /* Toggle screenlock for reading */
    clipboard-indicator /* Adds a clipboard indicator to the top panel, and caches clipboard history. */
    impatience          /* Speeds up animations. */
    nohotcorner         /* Disable hotcorners on Shell */
    dash-to-dock        /* OSX style dock. */
    dash-to-panel       /* Moves the dash to the gnome main panel */
    system-monitor      /* Shows system stats in bar */
    topicons-plus       /* Moves legacy tray icons to the top panel. */
  ]);

  extraPkgs = (with pkgs; [
    custom-icons            /* Install custom icons to GNOME */
    lockkeys                /* Numlock & Capslock status on the panel */
    password-store          /* Access passwords from pass (passwordstore.org) from the gnome-shell */
    shelltile               /* GNOME tiling manager */
    top-bar-script-executor /* Add buttons to the top bar that execute commands */
  ]);

  gnomeApps = (with pkgs.gnome3; [
    cheese        /* Photobooth (webcam tester) */
    dconf-editor  /* Advanced desktop config editor/viewer. */
    gnome-backgrounds
    gnome-themes-standard
    gnome-themes-extra
    gnome-tweaks
    gnome-tweak-tool
    networkmanager-openvpn
    polari        /* Modern IRC Client */
    sushi         /* Lightweight file previewer */
    totem         /* Movie player for Gnome based on GStreamer */
    vinagre       /* Remote desktop viewer */
    vino          /* Remote desktop server */
    zenity        /* graphical dialog prompts */
  ]);

  /* Packages w/ GLib Schemas */
  glibCompat = (with pkgs; [
    baobab
    liferea

  ]) ++ (with pkgs.gnome3; [
    cheese
    dconf-editor
    file-roller
    gedit
    gnome-calculator
    gnome-characters
    gnome-control-center
    gnome-disk-utility
    gnome-keyring
    gnome-logs
    gnome-nettool
    gnome-online-accounts
    gnome-power-manager
    gnome-screenshot
    gnome-settings-daemon
    gnome-shell
    gnome-shell-extensions
    /* gnome-system-monitor  /* Marked Broken ? */
    gnome-usage
    gpaste
    gtk3
    gvfs
    mutter
    nautilus
    polari
    seahorse
    totem
    vinagre
    vino
  ]);

in
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  services.flatpak = {
    enable = true;
  };

  services.xserver.desktopManager.gnome3.extraGSettingsOverridePackages = mkAfter glibCompat;

  environment.systemPackages = gnomeApps ++ gnomeExts ++ extraPkgs;

  nixpkgs.config.packageOverrides = pkgs: rec {
    custom-icons            = pkgs.callPackage ./pkgs/custom-icons.nix {};
    lockkeys                = pkgs.callPackage ./pkgs/lockkeys.nix {};
    password-store          = pkgs.callPackage ./pkgs/password-store.nix {};
    shelltile               = pkgs.callPackage ./pkgs/shelltile.nix {};
    top-bar-script-executor = pkgs.callPackage ./pkgs/top-bar-script-executor.nix {};
  };

  /* Don't install unnecessary gnome3 packages */
  environment.gnome3.excludePackages = (with pkgs.gnome3; [
    accerciser
    epiphany
    evolution
    evolution-data-server
    gnome-documents
    gnome-calendar
    gnome-contacts
    gnome-maps
    gnome-music
    gnome-online-miners
    gnome-packagekit
    gnome-photos
    gnome-software
    gnome-terminal
    gnome-todo
    gnome-user-docs
    gnome-user-share
    gnome-weather
    tracker
    tracker-miners
    yelp
  ]);

}; }
