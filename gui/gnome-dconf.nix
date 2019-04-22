{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable gui;

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
    else if (isList v && builtins.length v == 0) then "[\"\", nothing]"
    else if (isList v && builtins.length v > 0) then "[" + concatMapStringsSep "," fmtVal v + "]"
    else toString v);
  in lib.generators.toINI { 
    mkKeyValue = key: value: "${key}=${fmtVal value}";
  };
in
  { config = mkIf (enable && gui.enable) {

    /* DConf settings arent easily loaded properly. This simply uses the static
    dconf file generated by nixos-rebuild into Gnome's settings. */
    systemd.user.services.fnctl-dconf = {
      enable  = true;
      description = "Hacky dconf loader.";
      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
      path = with pkgs; [ gnome3.dconf ];
      serviceConfig = {
        ExecStart = "/bin/sh -c \"dconf load / < /etc/gnome3/fnctl-dconf.ini\"";
        Type = "oneshot";
      };
    };

    environment.etc."gnome3/fnctl-dconf.ini" = {
      mode = "0444";
      text = toDconf {

        "org/gnome/settings-daemon/plugins/xsettings"  =  {
          antialiasing  =  "grayscale";
          hinting  =  "medium";
        };

        "org/gnome/shell"  =  {
          app-picker-view  =  0;
          enabled-extensions  =  [
            "workspace-indicator@gnome-shell-extensions.gcampax.github.com"
            "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
            /* "apps-menu@gnome-shell-extensions.gcampax.github.com" */
            "alternate-tab@gnome-shell-extensions.gcampax.github.com"
          ];
          always-show-log-out  =  true;
          remember-mount-password  =  true;
          favorite-apps = [
            "${gui.defaultApps.terminal}.desktop"
            "${gui.defaultApps.browser}.desktop"
            "code.desktop"
            "org.gnome.Nautilus.desktop" 
          ];
        };

        "org/gnome/shell/keybindings"  =  {
          switch-to-application-1 = [];
          switch-to-application-2 = [];
          switch-to-application-3 = [];
          switch-to-application-4 = [];
          switch-to-application-5 = [];
          switch-to-application-6 = [];
          switch-to-application-7 = [];
          switch-to-application-8 = [];
          switch-to-application-9 = [];
          switch-to-application-10 = [];
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
            "Office" 
            "Security" 
            "System-Tools" 
            "Utilities"
          ];
        };

        "org/gnome/desktop/app-folders/folders/AudioVideo"  =  {
          name = "Audio & Video";
          categories = [
            "AudioVideo"
            "Audio"
            "Player"
            "Recorder"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Communication"  =  {
          name = "Chat";
          categories = [
            "InstantMessaging"
          ];
          apps = [
            "slack.desktop"
            "polari.desktop"
            "thunderbird.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Development"  =  {
          name = "Dev";
          categories = [
            "Development"
            "TerminalEmulator"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Graphics"  =  {
          name = "Graphics";
          categories = [
            "Graphics"
            "2DGraphics"
            "RasterGraphics"
            "Viewer"
            "Scanning"
          ];
          apps = [
            "dia.desktop"
            "draw.desktop"
            "gimp.desktop"
            "inkscape.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Office"  =  {
          name = "Office";
          categories = [
            "Office"
            "WebBrowser"
            "TextEditor"
            "Calculator"
            "Application"
            "WordProcessor"
          ];
          apps = [
            "impress.desktop"
            "draw.desktop"
            "math.desktop"
            "writer.desktop"
            "focuswriter.desktop"
          ];
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
          name = "Network";
        };

        "org/gnome/desktop/app-folders/folders/Security"  =  {
          name = "Security";
          categories = ["Security"];
          excluded-apps = [];
          apps = [
            "gnome-privacy-panel.desktop"
            "org.gnome.seahorse.Application.desktop"
          ];
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
          name = "System";
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
          name = "Utilities";
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
  }; }
