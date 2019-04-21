{ config, pkgs, lib, ... }: with lib;

let
  gnomeExts = (with pkgs.gnomeExtensions; [
    caffeine    /* Toggle screenlock for reading */
    impatience  /* Speeds up animations. */
  ]);

  /* Generates a DConf-style INI file from attributes of the form:

  Example Usage:
  ```
  toDconf {
  "org/gnome/settings-daemon/plugins/xsettings" = {
  antialiasing = "grayscale";
  hinting = "slight";
  };
  }
  ```*/
  toDconf = 
  let
    fmtVal = (v:
    if isBool v then (if v then "true" else "false")
    else if isString v then "'${v}'"
    else if isList v then "[" + concatMapStringsSep "," fmtVal v + "]"
    else toString v);
  in lib.generators.toINI { 
    mkKeyValue = key: value: "${key}=${fmtVal value}";
  };

in
  { config = mkIf (with config.fnctl2; enable && gui.enable) {

    services = {
      xserver.desktopManager.gnome3 = mkForce {
        enable = true;
        extraGSettingsOverrides  =  toDconf {

          "org/gnome/settings-daemon/plugins/xsettings"  =  {
            antialiasing  =  "grayscale";
            hinting  =  "slight";
          };

          "org/gnome/shell"  =  {
            app-picker-view  =  1;
            enabled-extensions  =  [
              "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
              "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
              "apps-menu@gnome-shell-extensions.gcampax.github.com"
              "alternate-tab@gnome-shell-extensions.gcampax.github.com"
            ];
            always-show-log-out  =  true;
            remember-mount-password  =  true;
            favorite-apps = [
              "alacritty.desktop"
              "firefox.desktop"
              "code.desktop"
              "org.gnome.Nautilus.desktop" 
            ];
          };

          "org/gnome/shell/window-switcher"  =  {
            current-workspace-only = false;
            app-icon-mode = "both";
          };

          "org/gnome/desktop/lockdown"  =  {
            user-administration-disabled = true;
          };

          "org/gnome/shell/overrides"  =  {
            workspaces-only-on-primary = false;
            attach-modal-dialogs = true;
          };

          "org/gnome/power-manager"  =  {
            info-history-type = "charge";
            info-stats-type = "discharge-accuracy";
            info-last-device = "wakeups";
            info-page-number = 3;
          };

          "org/gnome/desktop/wm/preferences"  =  {
            titlebar-font = "NotoSansDisplay Nerd Font 11";
            titlebar-uses-system-font = false;
            audible-bell = false;
            visual-bell = true;
            visual-bell-type = "frame-flash";
            resize-with-right-button = true;
            action-middle-click-titlebar = "minimize";
            action-left-click-titlebar = "toggle-maximize";
            action-right-click-titlebar = "menu";
            button-layout = "appmenu:minimize,close";
          };

          "org/gnome/desktop/app-folders"  =  {
            folder-children  =  [
              "AudioVideo" 
              "Communication" 
              "Development" 
              "Graphics" 
              "Network" 
              "System-Tools" 
              "Utilities"
            ];
          };

          "org/gnome/desktop/app-folders/folders/AudioVideo"  =  {
            name = "AudioVideo.directory";
            categories = [
              "AudioVideo"
              "Audio"
              "Player"
              "Recorder"
            ];
          };

          "org/gnome/desktop/app-folders/folders/Communication"  =  {
            categories = [
              "InstantMessaging"
            ];
            apps = [
              "slack.desktop"
              "thunderbird.desktop"
            ];
            name = "Communication.directory";
          };

          "org/gnome/desktop/app-folders/folders/Development"  =  {
            categories = [
              "Development"
              "TerminalEmulator"
            ];
            name = "Development.directory";
          };

          "org/gnome/desktop/app-folders/folders/Graphics"  =  {
            name = "Graphics.directory";
            categories = [
              "Graphics"
              "2DGraphics"
              "RasterGraphics"
              "Viewer"
              "Scanning"
            ];
          };

          "org/gnome/desktop/app-folders/folders/Office"  =  {
            categories = [
              "Office"
              "WebBrowser"
              "TextEditor"
              "Calculator"
              "Application"
              "WordProcessor"
            ];
            apps = [
              "dia.desktop"
            ];
            excluded-apps = [
              "code.desktop"
              "org.gnome.gedit.desktop"
            ];
            name = "Office.directory";
          };

          "org/gnome/desktop/app-folders/folders/Network"  =  {
            categories = [
              "Network"
              "FileTransfer"
              "X-GNOME-NetworkSettings"
              "RemoteAccess"
            ];
            apps = [
              "gnome-nettool.desktop"
            ];
            excluded-apps = [
              "slack.desktop"
            ];
            name = "Network.directory";
          };

          "org/gnome/desktop/app-folders/folders/System-Tools"  =  {
            categories = [
              "System-Tools"
              "Settings"
              "HardwareSettings"
              "System"
              "Monitor"
              "Filesystem"
              "Preferences"
              "Install"
              "Store"
              "Security"
              "PackageManager"
            ];
            apps = [
              "org.gnome.gedit.desktop"
              "redshift-gtk.desktop"
              "org.gnome.tweaks.desktop"
              "yelp.desktop"
            ];
            excluded-apps = [
              "kitty.desktop"
              "nm-connection-editor.desktop"
              "org.gnome.GPaste.Ui.desktop"
              "simple-scan.desktop"
              "wireshark-gtk.desktop"
              "xterm.desktop"
            ];
            name = "X-GNOME-SystemSettings.directory";
          };

          "org/gnome/desktop/app-folders/folders/Utilities"  =  {
            categories = [
              "X-GNOME-Utilities"
              "Utility"
              "FileTools"
              "Filesystem"
              "Archiving"
              "Compression"
              "Security"
            ];
            apps = [
              "simple-scan.desktop"
              "org.gnome.GPaste.Ui.desktop"
              "calc.desktop"
            ];
            excluded-apps = [
              "code.desktop"
              "gnome-nettool.desktop"
              "nvim.desktop"
              "org.gnome.gedit.desktop"
              "org.gnome.Logs.desktop"
              "org.gnome.tweaks.desktop"
              "redshift-gtk.desktop"
            ];
            name = "X-GNOME-Utilities.directory";
          };

          "org/gnome/desktop/background"  =  {
            show-desktop-icons = true;
          };

          "org/gnome/desktop/datetime"  =  {
            automatic-timezone = true;
          };

          "org/gnome/desktop/privacy"  =  {
            disable-camera = true;
            disable-microphone = false;
            remove-old-temp-files = true;
            remove-old-trash-files = true;
            disable-sound-output = false;
            hide-identity = true;
            old-files-age = 7;
            recent-files-max-age = 21;
          };

          "org/gnome/desktop/media-handling"  =  {
            automount = true;
            automount-open = true;
            autorun-never = true;
            autorun-x-content-start-app = [];
          };

          "org/gnome/desktop/notifications"  =  {
            application-children = [
              "gnome-network-panel"
            ];
          };

          "org/gnome/desktop/notifications/application/gnome-network-panel"  =  {
            application-id = "gnome-network-panel.desktop";
          };

          "org/gnome/desktop/peripherals/touchpad"  =  {
            natural-scroll = false;
            tap-to-click = true;
          };

          "org/gnome/desktop/interface"  =  {
            clock-show-date = true;
            clock-format = "12h";
            gtk-theme = "Adwaita-dark";
            gtk-im-module = "gtk-im-context-simple";
            show-battery-percentage = true;
          };

          "org/gnome/desktop/input-sources"  =  {
            xkb-options  =  concatStringsSep "," [
              "ctrl:nocaps" 
              "altwin:swap_lalt_lwin"
            ];
          };

          "org/gnome/desktop/search-providers"  =  {
            sort-order = [
              "org.gnome.Contacts.desktop"
              "org.gnome.Documents.desktop"
              "org.gnome.Nautilus.desktop"
            ];
            
            disable-external = true;
          };

          "org/gnome/control-center"  =  {
            last-panel = "display";
          };

          "org/gnome/nm-applet"  =  {
            suppress-wireless-networks-available = true;
          };

          "org/gtk/settings/file-chooser"  =  {
            clock-format = "12h";
            show-size-column = true;
            show-hidden = true;
            sort-directories-first = true;
            location-mode = "filename-entry";
          };

          "org/gnome/gnome-session"  =  {
            auto-save-session = true;
          };
        };
      };
    };
  }; }
