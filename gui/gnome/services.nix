{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable gui;

  gnomeExts = (with pkgs; [
    lockkeys                /* Numlock & Capslock status on the panel */
    password-store          /* Access passwords from pass (passwordstore.org) from the gnome-shell */
    shelltile               /* Tiling support for GNOME */
    top-bar-script-executor /* Add buttons to the top bar that execute commands */

  ]) ++ (with pkgs.gnomeExtensions; [
    appindicator        /* app icons in top bar */
    caffeine            /* Toggle screenlock for reading */
    clipboard-indicator /* Adds a clipboard indicator to the top panel, and caches clipboard history. */
    impatience          /* Speeds up animations. */
    nohotcorner         /* Disable hotcorners on Shell */
    dash-to-dock        /* OSX style dock. */
    dash-to-panel       /* moves the dash to the gnome main panel */
    # system-monitor      /* shows system stats in bar */
    topicons-plus       /* moves legacy tray icons to the top panel. */
  ]);

in
{ config = mkIf (enable && gui.enable) {

  services = {
    /* Disables Gnome's package installer (broken?). */
    packagekit.enable = false;

    /* Add gnome extensions to dbus so it can be discovered */
    dbus.packages = gnomeExts;
    xserver.desktopManager.gnome3.sessionPath = gnomeExts;

    /* Configure Gnome service itself */
    gnome3     = {
      at-spi2-core.enable          =  mkForce false;  # assistive technology service
      chrome-gnome-shell.enable    = true;   # allows installing gnome shell extensions from chromium/chrome
      evolution-data-server.enable = mkForce false;  # services for storing address books and calendars
      gnome-disks.enable           = true;   # UDisks2 graphical front-end
      gnome-documents.enable       = false;  # document manager
      gnome-keyring.enable         = true;   # credential store
      gnome-online-accounts.enable = true;   # single sign-on framework online accounts
      gnome-online-miners.enable   = false;  # service that crawls through user's online content
      gnome-terminal-server.enable = false;  # service used for gnome-terminal
      gnome-user-share.enable      = false;  # share public folder on network
      gpaste.enable                = true;   # clipboard manager
      gvfs.enable                  = true;   # userspace virtual filesystem support library
      seahorse.enable              = true;   # credential manager search
      sushi.enable                 = true;   # quick previewer for nautilus
      tracker-miners.enable        = false;  # file search indexing service
      tracker.enable               = false;  # file search engine, tool, and metadata storage system

      /*
      services.geoclue2.enable = mkDefault true;
      services.dleyna-renderer.enable = mkDefault true;
      services.dleyna-server.enable = mkDefault true;
      services.telepathy.enable = mkDefault true;
      services.upower.enable = config.powerManagement.enable;
      services.dbus.packages = mkIf config.services.printing.enable [ pkgs.system-config-printer ];
      services.colord.enable = mkDefault true;
      services.packagekit.enable = mkDefault true;
      services.udev.packages = [ pkgs.gnome3.gnome-settings-daemon ];
      systemd.packages = [ pkgs.gnome3.vino ];
      services.flatpak.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      nixpkgs.config.vim.gui = "gtk3";
      fonts.fonts = [ pkgs.dejavu_fonts pkgs.cantarell-fonts ];
      services.xserver.displayManager.extraSessionFilePackages = [ pkgs.gnome3.gnome-session ];
      */
    };
  };

}; }
