{ config, pkgs, lib, ... }:
with lib;
with import ./_helpers.nix { inherit pkgs lib; };

let inherit (config.fnctl2) enable gui; in
{ config = mkIf (enable && gui.enable) {

    # Default theme(?)
    environment.systemPackages = with pkgs; [ nordic numix-cursor-theme arc-icon-theme ];

    environment.etc = {
      "dconf/profile/user" = {
        mode = "0444";
        text = concatStringsSep "\n" ["system-db:local" "user-db:user"];
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

          "org/gnome/shell" = let
            extHost = "gnome-shell-extensions.gcampax.github.com";
          in {
            enabled-extensions  =  [
              "workspace-indicator@${extHost}"
              "windowsNavigator@${extHost}"
              "arc-menu@${extHost}"
              "user-theme@${extHost}"
              "caffeine@patapon.info"
              "impatience@gfxmonk.net"
            ];
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
            small-bookmark-rows = true;
            show-warning = false;
            small-keys-list-rows = true;
            window-is-maximized = true;
            restore-view = true;
            use-shortpaths = true;
          };
        };
      };

      "dconf/db/local.d/90_app_seahorse" = {
        mode = "0444";
        text = toDconf {

          "apps/seahorse" = {
            server-auto-publish = true;
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
            font-name = "NotoSansDisplay Nerd Font 11";
            document-font-name = "NotoSansDisplay Nerd Font Condensed 11";
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

          "system/locale"  =  {
            region = "us";
          };

        };
      };
    };
  }; }
