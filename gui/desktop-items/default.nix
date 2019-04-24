{ config, pkgs, lib, ... }: with lib;
let
  inherit (config.fnctl2) enable gui;
  iconDir = "${pkgs.arc-icon-theme}/share/icons/Arc";
  # FIXME: Dont hardcode this...
  termCmd = "${pkgs.alacritty}/bin/alacritty";

in {
  config = mkIf (enable && gui.enable) {
    environment.systemPackages = with pkgs; [

      (makeDesktopItem {
        name = "Fnctl-Docs";
        desktopName = "Fnctl Docs";
        genericName = "Open FnCtl's Nix Documentation";
        exec = "xdg-open 'https://docs.fnctl.io'";
        icon = ./icons/fnctl-docs.png;
        type = "Application";
        categories = "Application;Docs;Help;Documentation";
      })

      (makeDesktopItem {
        name = "fnctl-gitlab";
        desktopName = "Fnctl GitLab";
        genericName = "Open FnCtl's GitLab Group";
        exec = "xdg-open 'https://gitlab.com/fnctl'";
        icon = ./icons/fnctl-gitlab.png;
        type = "Application";
        categories = "Application;Docs;Help;Documentation";
      })

      (makeDesktopItem {
        name = "fnctl-issues";
        desktopName = "Fnctl Issues";
        genericName = "Open FnCtl's GitLab Issue Tracker";
        exec = "xdg-open 'https://gitlab.com/groups/fnctl/-/issues'";
        icon = ./icons/fnctl-issue.png;
        type = "Application";
        categories = "Application;Docs;Help;Documentation";
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
