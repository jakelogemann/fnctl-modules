{ config, pkgs, lib, ... }:
with lib;
with import ./_helpers.nix { inherit pkgs lib; };

let inherit (config.fnctl2) enable gui; in
{ config = mkIf (enable && gui.enable) {

    # Default theme(?)
    environment.systemPackages = with pkgs; [
      nordic
      numix-cursor-theme
      arc-icon-theme
    ];

    environment.etc = {
      "dconf/profile/user" = {
        mode = "0444";
        text = concatStringsSep "\n" ["user-db:user" "system-db:local"];
      };

      "dconf/db/local.d/10_favorite_apps" = {
        mode = "0444";
        text = toDconf {
          "org/gnome/shell" =  {
            favorite-apps = [
              "org.gnome.Nautilus.desktop"
              "${gui.defaultApps.terminal}.desktop"
              "${gui.defaultApps.browser}.desktop"
              "${gui.defaultApps.editor}.desktop"
              "slack.desktop"
              "thunderbird.desktop"
              "spotify.desktop"
              "org.gnome.seahorse.Application.desktop"
            ];
          };
        };
      };

      "dconf/db/local.d/20_extensions" = {
        mode = "0444";
        text = toDconf {

          "org/gnome/shell" = {
            enabled-extensions  = gui.defaultApps.gnomeExtensions;
          };

          "org/gnome/shell/extensions/user-theme"  =  {
            name = "Nordic";
          };

          "org/gnome/shell/extensions/caffeine"  =  {
            restore-state = true;
          };

          "org/gnome/shell/extensions/net/gfxmonk/impatience" = {
            speed-factor = 0.75;
          };

          "org/gnome/shell/extensions/dash-to-panel" = {
            show-apps-icon-file = "";
            show-apps-icon-side-padding = 0;
            dot-color-unfocused-1 = "#5294e2";
            dot-color-unfocused-2 = "#5294e2";
            dot-color-unfocused-3 = "#5294e2";
            dot-color-unfocused-4 = "#5294e2";
            dot-position = "BOTTOM";
            focus-highlight-color = "#eeeeee";
            panel-size = 24;
            dot-style-focused = "METRO";
            location-clock = "BUTTONSLEFT";
            shift-click-action = "MINIMIZE";
            hotkeys-overlay-combo = "TEMPORARILY";
            dot-color-1 = "#5294e2";
            dot-color-2 = "#5294e2";
            dot-color-3 = "#5294e2";
            dot-color-4 = "#5294e2";
            dot-style-unfocused = "METRO";
            secondarymenu-contains-showdetails = false;
            panel-position = "TOP";
            appicon-margin = 4;
            shift-middle-click-action = "LAUNCH";
            show-activities-button = false;
            middle-click-action = "LAUNCH";
            show-showdesktop-button = false;
            appicon-padding = 4;
            taskbar-position = "LEFTPANEL_FIXEDCENTER";
          };

          "org/gnome/shell/extensions/system-monitor" = {
            battery-show-text = true;
            center-display = false;
            fan-display = false;
            show-tooltip = false;
            gpu-display = false;
            battery-hidesystem = false;
            compact-display = true;
            icon-display = false;
            net-display = false;
            net-show-text = true;
            freq-display = false;
            move-clock = false;
            net-style = "digit";
            memory-style = "digit";
            swap-display = false;
            battery-show-menu = true;
            thermal-display = false;
            freq-style = "digit";
            swap-style = "digit";
            thermal-style = "digit";
            cpu-style = "digit";
            fan-style = "digit";
            gpu-show-menu = true;
            gpu-style = "digit";
            disk-display = false;
            disk-style = "digit";
            net-show-menu = true;
          };

          "org/gnome/shell/extensions/topicons" = {
            icon-brightness = 0.0;
            icon-size = 16;
            icon-spacing = 4;
            tray-pos = "right";
            icon-saturation = 0.5;
            tray-order = 1;
          };
        };
      };

      "dconf/db/local.d/30_keybinds" = {
        mode = "0444";
        text = toDconf {
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
        };
      };

      "dconf/db/local.d/90_app_dconfeditor" = {
        mode = "0444";
        text = toDconf {
          "ca/desrt/dconf-editor" = {
            small-bookmarks-rows = true;
            show-warning = false;
            small-keys-list-rows = true;
            window-is-maximized = false;
            restore-view = false;
            window-height = "600";
            window-width = "800";
            use-shortpaths = true;
          };
        };
      };

      "dconf/db/local.d/90_app_seahorse" = {
        mode = "0444";
        text = toDconf {

          "apps/seahorse" = {
            server-auto-retrieve = true;
            server-publish-to = "hkp://pool.sks-keyservers.net";
          };

          "apps/seahorse/listing" = {
            sidebar-visible = false;
          };

        };
      };


      "dconf/db/local.d/99_unsorted" = {
        mode = "0444";
        text = toDconf {

          "org/gnome/settings-daemon/plugins/xsettings"  =  {
            antialiasing  =  "rgba";
            hinting  =  "medium";
          };

          "org/gtk/settings/debug" = {
            enable-inspector-keybinding = true;
            inspector-warning = true;
          };

          "org/gnome/shell"  =  {
            app-picker-view  =  1;
            always-show-log-out  =  true;
            remember-mount-password  =  true;
          };

          "org/gnome/shell/window-switcher"  =  {
            current-workspace-only = true;
            app-icon-mode = "both";
          };

          "org/gnome/shell/app-switcher"  =  {
            current-workspace-only = true;
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
            titlebar-font = "Cantarell Bold 11";
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
          };

          "org/gnome/desktop/interface"  =  {
            clock-show-date = true;
            clock-format = "12h";
            gtk-theme = "Nordic";
            icon-theme = "Arc";
            gtk-key-theme = "Emacs";
            cursor-theme = "Numix-Cursor";
            monospace-font-name = "FuraMono Nerd Font Mono 11";
            font-name = "Cantarell 11";
            document-font-name = "Cantarell 11";
            show-battery-percentage = true;
          };

          "org/gnome/desktop/input-sources"  =  {
            sources = [
              "('xkb', 'us')"
            ];
            xkb-options  =  [
                "ctrl:nocaps"
                "altwin:swap_lalt_lwin"
                "terminate:ctrl_alt_bksp"
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

          "org/gnome/nm-applet"  =  {
            suppress-wireless-networks-available = true;
          };

          "org/gtk/settings/file-chooser"  =  {
            clock-format = "12h";
            sort-column = "name";
            sort-order = "ascending";
            sort-directories-first = false;
            location-mode = "filename-entry";
          };

          "org/gnome/gnome-session"  =  {
            auto-save-session = true;
          };

          "system/locale"  =  {
            region = "us";
          };

        };
      };
    };
  }; }
