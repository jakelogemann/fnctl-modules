{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable gui;

  gnomeExts = (with pkgs.gnomeExtensions; [
    caffeine     /* Toggle screenlock for reading */
    impatience   /* Speeds up animations. */
    nohotcorner  /* Disable hotcorners on Shell */
    dash-to-dock /* OSX style dock. */
    tilingnome   /* Tiling Gnome features. */
    topicons-plus  /* Status tray */
    gsconnect   /* local device manager */
  ]);

  gnomeApps = (with pkgs.gnome3; [
    gnome-backgrounds
    polari        /* Modern IRC Client */
    sushi         /* Lightweight file previewer */
    dconf-editor  /* Advanced deskto config editor/viewer. */
    totem         /* Movie player for Gnome based on GStreamer */
    vinagre       /* Remote desktop viewer */
    vino          /* Remote desktop server */
    zenity        /* graphical dialog prompts */
    cheese        /* Photobooth (webcam tester) */
    gnome-themes-standard gnome-themes-extra
    gnome-tweaks
    gnome-tweak-tool
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
    gnome-system-monitor
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
