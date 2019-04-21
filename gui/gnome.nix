{ config, pkgs, lib, ... }: with lib; 
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  services = {
    /* Disables Gnome's package installer (broken?). */
    packagekit.enable = false;

    /* Automatically hide the mouse cursor after being idle. */
    unclutter = {
      enable = true;
      keystroke = true;
    };

    xserver.desktopManager.gnome3 = mkForce {
      enable = true;
      extraGSettingsOverrides = ''

        [org/gnome/settings-daemon/plugins/xsettings]
        antialiasing='grayscale'
        hinting='slight'

        [org/gnome/shell]
        app-picker-view=uint32 1
        enabled-extensions=['workspace-indicator@gnome-shell-extensions.gcampax.github.com', 'windowsNavigator@gnome-shell-extensions.gcampax.github.com', 'apps-menu@gnome-shell-extensions.gcampax.github.com', 'alternate-tab@gnome-shell-extensions.gcampax.github.com']
        always-show-log-out=true
        remember-mount-password=true
        favorite-apps=['alacritty.desktop', 'firefox.desktop', 'code.desktop', 'org.gnome.Nautilus.desktop']

        [org/gnome/shell/window-switcher]
        current-workspace-only=false
        app-icon-mode='both'

        [org/gnome/desktop/lockdown]
        user-administration-disabled=true

        [org/gnome/shell/overrides]
        workspaces-only-on-primary=false
        attach-modal-dialogs=true

        [org/gnome/power-manager]
        info-history-type='charge'
        info-stats-type='discharge-accuracy'
        info-last-device='wakeups'
        info-page-number=3

        [org/gnome/desktop/wm/preferences]
        titlebar-font='NotoSansDisplay Nerd Font 11'
        titlebar-uses-system-font=false
        audible-bell=false
        visual-bell=true
        visual-bell-type='frame-flash'
        resize-with-right-button=true
        action-middle-click-titlebar='minimize'
        action-left-click-titlebar='toggle-maximize'
        action-right-click-titlebar='menu'
        button-layout='appmenu:minimize,close'

        [org/gnome/desktop/app-folders]
        folder-children=['AudioVideo', 'Communication', 'Development', 'Graphics', 'Network', 'System-Tools', 'Utilities']

        [org/gnome/desktop/app-folders/folders/AudioVideo]
        categories=['AudioVideo', 'Audio', 'Player', 'Recorder']
        name='AudioVideo.directory'

        [org/gnome/desktop/app-folders/folders/Communication]
        categories=['InstantMessaging']
        apps=['slack.desktop', 'thunderbird.desktop']
        name='Communication.directory'

        [org/gnome/desktop/app-folders/folders/Development]
        categories=['Development', 'TerminalEmulator']
        name='Development.directory'

        [org/gnome/desktop/app-folders/folders/Graphics]
        categories=['Graphics', '2DGraphics', 'RasterGraphics', 'Viewer', 'Scanning']
        name='Graphics.directory'

        [org/gnome/desktop/app-folders/folders/Office]
        categories=['Office', 'WebBrowser', 'TextEditor', 'Calculator', 'Application', 'WordProcessor']
        apps=['dia.desktop']
        excluded-apps=['code.desktop', 'org.gnome.gedit.desktop']
        name='Office.directory'

        [org/gnome/desktop/app-folders/folders/Network]
        categories=['Network', 'FileTransfer', 'X-GNOME-NetworkSettings', 'RemoteAccess']
        apps=['gnome-nettool.desktop']
        excluded-apps=['slack.desktop']
        name='Network.directory'

        [org/gnome/desktop/app-folders/folders/System-Tools]
        categories=['System-Tools', 'Settings', 'HardwareSettings', 'System', 'Monitor', 'Filesystem', 'Preferences', 'Install', 'Store', 'Security', 'PackageManager']
        apps=['org.gnome.gedit.desktop', 'redshift-gtk.desktop', 'org.gnome.tweaks.desktop', 'yelp.desktop']
        excluded-apps=['kitty.desktop', 'nm-connection-editor.desktop', 'org.gnome.GPaste.Ui.desktop', 'simple-scan.desktop', 'wireshark-gtk.desktop', 'xterm.desktop']
        name='X-GNOME-SystemSettings.directory'

        [org/gnome/desktop/app-folders/folders/Utilities]
        categories=['X-GNOME-Utilities', 'Utility', 'FileTools', 'Filesystem', 'Archiving', 'Compression', 'Security']
        apps=['simple-scan.desktop', 'org.gnome.GPaste.Ui.desktop', 'calc.desktop']
        excluded-apps=['code.desktop', 'gnome-nettool.desktop', 'nvim.desktop', 'org.gnome.gedit.desktop', 'org.gnome.Logs.desktop', 'org.gnome.tweaks.desktop', 'redshift-gtk.desktop']
        name='X-GNOME-Utilities.directory'

        [org/gnome/desktop/background]
        show-desktop-icons=true

        [org/gnome/desktop/datetime]
        automatic-timezone=true

        [org/gnome/desktop/privacy]
        disable-camera=true
        disable-microphone=false
        disable-sound-output=false
        hide-identity=true
        old-files-age=7
        recent-files-max-age=21

        [org/gnome/desktop/media-handling]
        automount=true
        automount-open=true
        autorun-never=true
        autorun-x-content-start-app=[]

        [org/gnome/desktop/notifications]
        application-children=['gnome-network-panel']

        [org/gnome/desktop/notifications/application/gnome-network-panel]
        application-id='gnome-network-panel.desktop'

        [org/gnome/desktop/peripherals/touchpad]
        natural-scroll=false
        tap-to-click=true

        [org/gnome/desktop/interface]
        clock-show-date=true
        clock-format='12h'
        gtk-theme='Adwaita-dark'
        gtk-im-module='gtk-im-context-simple'
        show-battery-percentage=true

        [org/gnome/desktop/input-sources]
        sources=[('xkb', 'us')]
        xkb-options=['ctrl:nocaps,altwin:swap_lalt_lwin']

        [org/gnome/desktop/search-providers]
        sort-order=['org.gnome.Contacts.desktop', 'org.gnome.Documents.desktop', 'org.gnome.Nautilus.desktop']
        disable-external=true

        [org/gnome/desktop/privacy]
        remove-old-temp-files=true
        remove-old-trash-files=true

        [org/gnome/control-center]
        last-panel='display'

        [org/gnome/nm-applet]
        suppress-wireless-networks-available=true

        [org/gtk/settings/file-chooser]
        clock-format='12h'
        show-size-column=true
        show-hidden=true
        sort-directories-first=true
        location-mode='filename-entry'

        [org/gnome/gnome-session]
        auto-save-session=true
      '';
    };

    /* Configure Gnome service itself */
    gnome3     = {
      /* at-spi2-core.enable        = false;  # assistive technology service */
      chrome-gnome-shell.enable    = true;   # allows installing gnome shell extensions from chromium/chrome
      evolution-data-server.enable = lib.mkForce false;  # services for storing address books and calendars
      gnome-disks.enable           = true;   # UDisks2 graphical front-end
      gnome-documents.enable       = false;  # document manager
      /* gnome-keyring.enable         = true;   # credential store   */
      gnome-online-accounts.enable = true;   # single sign-on framework online accounts
      gnome-online-miners.enable   = false;  # service that crawls through user's online content
      gnome-terminal-server.enable = false;  # service used for gnome-terminal
      gnome-user-share.enable      = false;  # share public folder on network
      gpaste.enable                = true;   # clipboard manager
      /* gvfs.enable               = true;   # userspace virtual filesystem support library  */
      seahorse.enable              = true;  # credential manager search
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

  environment = {
    systemPackages = with pkgs; [
      gnome3.gnome-backgrounds
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
      totem
      tracker
      tracker-miners
      vinagre
      vino
      yelp
    ]);
  };

}; }
