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
    # system-monitor      /* Shows system stats in bar */
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
    cheese                 # Photobooth (webcam tester)
    dconf-editor           # Advanced desktop config editor/viewer.
    gnome-backgrounds      # Background images for the GNOME desktop
    gnome-mahjongg         # Dissemble a pile of tiles by removing matching pairs
    gnome-mines            # Clear hidden mines from a minefield
    gnome-sudoku           # Test logic skills in a number grid puzzle
    gnome-themes-standard  # Adwaita and High Constrast themes
    gnome-themes-extra     # Additional Adwaita-dark theme, icons, and index files
    gnome-tweaks           # A tool to customize advanced GNOME 3 options
    nautilus-sendto        # Integrates Evolution and Pidgin into the Nautilus file manager
    networkmanager-openvpn # NetworkManager's OpenVPN plugin
    pidgin-im-gnome-shell-extension # Make Pidgin IM conversations appear in the Gnome shell message tray
    polari                 # Modern IRC Client
    sushi                  # Lightweight file previewer
    totem                  # Movie player for Gnome based on GStreamer
    vinagre                # Remote desktop viewer
    vino                   # Remote desktop server
    zenity                 # graphical dialog prompts
  ]);

  /* Packages w/ GLib Schemas */
  glibCompat = (with pkgs; [
    baobab                 # Graphical application to analyse disk usage in any GNOME environment
    liferea                # A GTK-based news feed aggregator

  ]) ++ (with pkgs.gnome3; [
    file-roller            # Archive manager
    gedit                  # Official text editor of the GNOME desktop environment
    gnome-calculator       # Default GNOME calculator
    gnome-characters       # Simple utility app to find and insert unusual chars
    gnome-control-center   # Utilities to configure the GNOME desktop
    gnome-disk-utility     # A udisks graphical front-end
    gnome-keyring          # Store secrets, passwords, keys, and certs, and make available to apps
    gnome-logs             # Log viewer for the systemd journal
    gnome-nettool          # Networking tools
    gnome-online-accounts  # Single sign-on framwork for GNOME
    gnome-power-manager    # View battery and power statistics provided by UPower
    gnome-screenshot       # Take screenshots
    gnome-settings-daemon  # Sets various params of the session and apps in a session
    gnome-shell            # Core user interface
    # gnome-shell-extensions # Modify and extend GNOME Shell functionality and behavior
    gnome-system-monitor   # Processor time, memory, and disk space utilization tool
    gnome-usage            # View information about the use of system resources
    gpaste                 # Clipboard management system with GNOME3 integration
    gtk3                   # A multi-platform toolkit for creating graphical user interfaces
    gvfs                   # Virtual Filesystem support library
    mutter                 # Default window manager in GNOME 3 for Wayland and X11
    nautilus               # The file manager for GNOME
    seahorse               # Application for managing encryption keys and passwords in teh GnomeKeyring
  ]);

in
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  # Linux application sandboxing and distribution framework
  services.flatpak = {
    enable = true;
  };

  # Attempt to make package settings editable with dConf
  services.xserver.desktopManager.gnome3.extraGSettingsOverridePackages = mkAfter glibCompat;

  environment.systemPackages = gnomeApps ++ gnomeExts ++ extraPkgs;

  # Reference custom package derivations
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
