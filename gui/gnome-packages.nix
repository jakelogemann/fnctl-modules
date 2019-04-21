{ config, pkgs, lib, ... }: with lib;

let
  gnomeExts = (with pkgs.gnomeExtensions; [
    caffeine    /* Toggle screenlock for reading */
    impatience  /* Speeds up animations. */
  ]);

in
{ config = mkIf (with config.fnctl2; enable && gui.enable) {
  environment = {
    systemPackages = with pkgs.gnome3; [
      gnome-backgrounds
      polari        /* Modern IRC Client */
      sushi         /* Lightweight file previewer */
      dconf-editor  /* Advanced deskto config editor/viewer. */
      totem         /* Movie player for Gnome based on GStreamer */
      vinagre vino  /* Remote desktop viewer/server */
      zenity        /* graphical dialog prompts */
    ];

    /* Don't install unnecessary gnome3 packages */
    gnome3.excludePackages = (with pkgs.gnome3; [
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
  };
}; }

