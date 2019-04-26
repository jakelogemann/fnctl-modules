{ config, pkgs, lib, ... }:
with lib;
with import ./_helpers.nix { inherit pkgs lib; };

let
  inherit (config.fnctl2) enable gui;
  /*
  this attr set is defined early to allow for 'excluded-apps' to be
  generated for each app folder at compile time. By doing this we can ensure
  that each app explicitly placed in a folder is placed exclusively in that
  folder and no others.
  See Also: https://standards.freedesktop.org/menu-spec/latest/apas02.html
  */
  appDirs = {
    "AudioVideo" = {
      name = "Audio & Video";
      categories = [
        "AudioVideo"
        "Audio"
        "Player"
        "Recorder"
      ];
    };

    "Terminal" = {
      name = "Terminals";
      categories = ["TerminalEmulator"];
      apps = [
        "alacritty.desktop"
        "kitty.desktop"
        "xterm.desktop"
      ];
    };

    "Communication"  =  {
      name = "Chat";
      categories = ["InstantMessaging"];
      apps = [
        "slack.desktop"
        "org.gnome.Polari.desktop"
        "pidgin.desktop"
        "signal-desktop.desktop"
        "thunderbird.desktop"
        "net.sourceforge.liferea.desktop"
      ];
    };

    "HelpDocs"  =  {
      name = "Help & Docs";
      categories = [
        "Docs"
        "Documentation"
        "Help"
        "Manual"
      ];
      apps = [
        "nixos-manual.desktop"
        "org.zealdocs.Zeal.desktop"
      ];
    };

    "Storage"  =  {
      name = "Storage";
      categories = [
        "Filesystem"
        "FileTools"
        "Archiving"
        "Compression"
      ];
      apps = [
        "org.gnome.Nautilus.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.baobab.desktop"
        "gnome-disk-image-mounter.desktop"
        "gnome-disk-image-writer.desktop"
      ];
    };

    "NetworkAnalysis"  =  {
      name = "Net Analysis";
      categories = ["Network"];
      apps = [
        "wireshark.desktop"
        "zenmap.desktop"
        "zenmap-root.desktop"
        "gnome-nettool.desktop"
      ];
    };

    "Development"  =  {
      name = "Dev";
      categories = [
        "Development"
        "IDE"
        "TextEditor"
      ];
      apps = [
        "code.desktop"
        "nvim.desktop"
        "gnvim.desktop"
        "org.gnome.gedit.desktop"
        "emacs.desktop"
        "postman.desktop"
      ];
    };

    "Design & Graphics"  =  {
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
        "pencil.desktop"
        "draw.desktop"
        "gimp.desktop"
        "inkscape.desktop"
      ];
    };

    "Office"  =  {
      name = "Office";
      categories = ["Office" "WordProcessor"];
      apps = [
        "impress.desktop"
        "draw.desktop"
        "calc.desktop"
        "simple-scan.desktop"
        "math.desktop"
        "writer.desktop"
        "focuswriter.desktop"
      ];
    };

    "Security"  =  {
      name = "Security";
      categories = ["Security"];
      apps = [
        "gnome-privacy-panel.desktop"
        "org.gnome.seahorse.Application.desktop"
        "ykman-gui.desktop"
      ];
    };

    "Settings"  =  {
      name = "Settings";
      categories = [
        "Settings"
        "HardwareSettings"
        "Preferences"
        "X-GNOME-NetworkSettings"
      ];
        apps = [
          "org.gnome.tweaks.desktop"
          "rygel.desktop" "rygel-preferences.desktop"  /* UPnP */
          "ca.desrt.dconf-editor.desktop"
          "arandr.desktop"
          "gnome-system-monitor.desktop"
          "org.gnome.Usage.desktop"
          "org.gnome.PowerStats.desktop"
        ];
      };

    "Store"  =  {
      name = "Package Stores";
      categories = ["Install" "Store" "PackageManager"];
    };

    "P2P"  =  {
      name = "P2P & Sharing";
      categories = ["FileTransfer" "P2P" "RemoteAccess"];
      apps = [
        "deluge.desktop"
        "vinagre.desktop"
        "bluetooth-sendto.desktop"
        "vinagre-file.desktop"
        "vino-server.desktop"
      ];
    };

    "Web"  =  {
      name = "Web Browsers";
      categories = ["WebBrowser"];
      apps = [
        "chromium-browser.desktop"
        "google-chrome.desktop"
        "firefox.desktop"
        "qutebrowser.desktop"
      ];
    };

    "Utilities"  =  {
      name = "Utilities";
      categories = [
        "X-GNOME-Utilities"
        "Utility"
        "Security"
        "Calculator"
        "System-Tools"
        "System"
        "Monitor"
      ];
      apps = [
        "simple-scan.desktop"
        "gucharmap.desktop"
        "org.gnome.GPaste.Ui.desktop"
        "org.gnome.Cheese.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Characters.desktop"
        "org.gnome.Screenshot.desktop"
        "org.gnome.font-viewer.desktop"
      ];
    };

  }; /* </appDirs> */

  /* All named applications, flattened into one list and de-duped */
  allApps = unique (flatten (mapAttrsToList (n: v: (v.apps or [])) appDirs));

  /* Transforms attr set element into one consumable by toDconf. */
  makeAppFolder' = attrName: value:
  let
    gsettingsPrefix = "org/gnome/desktop/app-folders/folders";
    apps = value.apps or [];
    other-apps = (subtractLists apps allApps);
  in nameValuePair "${gsettingsPrefix}/${attrName}" (value // {
    excluded-apps = (value.excluded-apps or []) ++ other-apps;
  });

  /* Transforms entire attr set into one consumable by toDconf. */
  makeAppFolders' = attrSet: mapAttrs' makeAppFolder' attrSet;

in {
  config.environment.etc = mkIf (enable && gui.enable) {
    "dconf/db/local.d/50_app_folders" = {
      mode = "0444";
      text = toDconf ({
        "org/gnome/desktop/app-folders".folder-children = attrNames appDirs;
      } // (makeAppFolders' appDirs));
    };
  };
}
