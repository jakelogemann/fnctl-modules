{ config, pkgs, lib, ... }: with lib;
with (import ../gnome/_helpers.nix { inherit pkgs lib; });

let inherit (config.fnctl2) enable gui; in {
  config = mkIf (enable && gui.enable) {
    environment.systemPackages = [(pkgs.buildEnv {
      name = "gnvim-appitems";
      paths = with pkgs; [
        (makeDesktopItem {
          name = "gnvim";
          desktopName = "GNvim";
          exec = openEditor { inherit (gui.defaultApps) editor; };
          icon = ./icons/gnvim.svg;
          type = "Application";
          categories = "TextEditor";
        })
      ];
    })];
  };
}
