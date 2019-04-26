{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable gui;

  gnomeExts = (with pkgs.gnomeExtensions; [
    appindicator       /* app icons in top bar */
    caffeine           /* Toggle screenlock for reading */
    impatience         /* Speeds up animations. */
    nohotcorner        /* Disable hotcorners on Shell */
    dash-to-dock       /* OSX style dock. */
    dash-to-panel      /* moves the dash to the gnome main panel */
    /* system-monitor     /* shows system stats in bar  /* Marked Broken ? */
    topicons-plus      /*  moves legacy tray icons to the top panel. */
  # tilingnome         /* Tiling Gnome features. */
  # workspace-grid     /* more tiling options */
  ]);

  gnomeApps = (with pkgs.gnome3; [
    cheese        /* Photobooth (webcam tester) */
    dconf-editor  /* Advanced deskto config editor/viewer. */
    gnome-backgrounds
    gnome-themes-standard
    gnome-themes-extra
    gnome-tweaks
    gnome-tweak-tool
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

  environment.systemPackages = gnomeApps ++ gnomeExts;

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
