{ config, pkgs, lib, ... }: 
with lib;
with import ./_helpers.nix { inherit pkgs lib; };

let inherit (config.fnctl2) enable gui; in { 
  config.environment.etc = mkIf (enable && gui.enable) {
    "dconf/db/local.d/50_app_folders" = {
      mode = "0444";
      text = toDconf {
        
        "org/gnome/desktop/app-folders"  =  {
          folder-children  =  [
            "AudioVideo" 
            "Communication" 
            "Development" 
            "Graphics" 
            "Network" 
            "Terminal" 
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

        "org/gnome/desktop/app-folders/folders/Terminal"  =  {
          name = "Terminals";
          categories = ["TerminalEmulator"];
          apps = [
            "alacritty.desktop"
            "kitty.desktop"
            "xterm.desktop"
          ];
        };

        "org/gnome/desktop/app-folders/folders/Communication"  =  {
          name = "Chat";
          categories = ["InstantMessaging"];
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

          ];
          apps = [
            "code.desktop"
            "nvim.desktop"
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
            "WebBrowser"
            "Calculator"
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

      };
    };
  }; 
}
