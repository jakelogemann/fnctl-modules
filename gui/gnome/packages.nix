{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable gui;
  gnomeExts = (with pkgs.gnomeExtensions; [
    caffeine    /* Toggle screenlock for reading */
    impatience  /* Speeds up animations. */
  ]);

in
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  services.flatpak = {
    enable = true;
  };

  services.xserver.desktopManager.gnome3 = {
    extraGSettingsOverridePackages = (with pkgs.gnome3; [
      gnome-shell
      gnome-shell-extensions
      gnome-usage
      gnome-characters
      # gnome-common
      gnome-session
      gnome-control-center
      gnome-keyring
      gnome-logs
      gnome-panel
      file-roller
      totem
      gvfs
      gtk
      polari
      vino
      vinagre
      dconf-editor
      nautilus
      gnome-nettool
      seahorse
    ]);
  };

  environment.systemPackages = (with pkgs.gnome3; [
    gnome-backgrounds
    polari        /* Modern IRC Client */
    sushi         /* Lightweight file previewer */
    dconf-editor  /* Advanced deskto config editor/viewer. */
    totem         /* Movie player for Gnome based on GStreamer */
    vinagre       /* Remote desktop viewer */
    vino          /* Remote desktop server */
    zenity        /* graphical dialog prompts */
    gnome-themes-standard gnome-themes-extra
    gnome-tweaks
    gnome-tweak-tool
  ]);

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

