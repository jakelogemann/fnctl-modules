{ config, pkgs, lib, ... }: with lib;
with (import ../gnome/_helpers.nix { inherit pkgs lib; });

let inherit (config.fnctl2) enable gui; in {
  config = mkIf (enable && gui.enable) {
    environment.systemPackages = [(pkgs.buildEnv {
      name = "fnctl-appitems";
      paths = with pkgs; [
        (makeDesktopItem {
          name = "com.torn.home";
          desktopName = "TORN Home";
          exec = openUrl {
            browserName = gui.defaultApps.browser;
            url = "https://torn.com/";
          };
          icon = ./icons/torn.png;
          type = "Application";
          categories = "Game";
        })
      ];
    })];
  };
}
