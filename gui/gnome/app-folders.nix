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
      ];
    };

    "HelpDocs"  =  {
      name = "Help & Docs";
      apps = [
        "nixos-manual.desktop"
        "org.zealdocs.Zeal.desktop"
        "Fnctl-Docs.desktop"
      ];
    };

    "Storage"  =  {
      name = "Storage";
      categories = [];
      apps = [
        "org.gnome.Nautilus.desktop"
        "org.gnome.FileRoller.desktop"
        "org.gnome.DiskUtility.desktop"
        "gnome-disk-image-mounter.desktop"
        "gnome-disk-image-writer.desktop"
      ];
    };

    "NetworkAnalysis"  =  {
      name = "Net Analysis";
      categories = [];
      apps = [
        "wireshark.desktop"
        "zenmap.desktop"
        "zenmap-root.desktop"
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
        "emacs.desktop"
        "postman.desktop"
      ];
    };

    "Graphics"  =  {
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

    "Office"  =  {
      name = "Office";
      categories = ["Office" "WordProcessor"];
      apps = [
        "impress.desktop"
        "draw.desktop"
        "math.desktop"
        "writer.desktop"
        "focuswriter.desktop"
      ];
    };

    "Network"  =  {
      name = "Network";
      categories = [
        "Network"
        "FileTransfer"
        "X-GNOME-NetworkSettings"
        "RemoteAccess"
      ];
      apps = [
        "gnome-nettool.desktop"
      ];
    };

    "Security"  =  {
      name = "Security";
      categories = ["Security"];
      apps = [
        "gnome-privacy-panel.desktop"
        "org.gnome.seahorse.Application.desktop"
      ];
    };

    "System-Tools"  =  {
      name = "System";
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
        "FileTools"
        "Filesystem"
        "Archiving"
        "Compression"
        "Security"
        "Calculator"
      ];
      apps = [
        "simple-scan.desktop"
        "org.gnome.GPaste.Ui.desktop"
        "calc.desktop"
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
