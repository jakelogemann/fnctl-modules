{ config, pkgs, lib, ... }: with lib;
let
  inherit (config.fnctl2) enable gui;
  iconDir = "${pkgs.arc-icon-theme}/share/icons/Arc";
  # FIXME: Dont hardcode this...
  termCmd = "${pkgs.alacritty}/bin/alacritty";

in { 
  config = mkIf (enable && gui.enable) {
    environment.variables."TERM" = mkForce gui.defaultApps.terminal;
    environment.sessionVariables."TERM" = gui.defaultApps.terminal;

    environment.systemPackages = with pkgs; [

      (makeDesktopItem {
        name = "Fnctl-Docs";
        desktopName = "Fnctl Docs";
        genericName = "Open the Documentation";
        exec = "xdg-open 'https://docs.fnctl.io'";
        icon = "${iconDir}/mimetypes/128@2x/x-office-document-template.png";
        type = "Application";
        categories = "Application;Development;";
      })

      (makeDesktopItem {
        name = "nvim";
        desktopName = "NeoVim";
        genericName = "Open the Editor";
        exec = "${termCmd} -e nvim %F";
        icon = "${iconDir}/status/128@2x/important.png";
        type = "Application";
        categories = "Application;Development;";
      })

    ];
  }; 
}
