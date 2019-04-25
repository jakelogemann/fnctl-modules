{ config, pkgs, lib, ... }: with lib;
with (import ../gnome/_helpers.nix { inherit pkgs lib; });
let
  inherit (config.fnctl2) enable gui;

  appItems = with pkgs; [
    (makeDesktopItem {
      name = "io.fnctl.docs";
      desktopName = "Fnctl Docs";
      exec = openUrl {
        browserName = gui.defaultApps.browser;
        url = "https://docs.fnctl.io";
      };
      icon = ./icons/fnctl-docs.png;
      type = "Application";
      categories = "Documentation";
    })

    (makeDesktopItem {
      name = "io.fnctl.gitlab-group";
      desktopName = "Fnctl GitLab";
      exec = openUrl {
        browserName = gui.defaultApps.browser;
        url = "https://gitlab.com/fnctl";
      };
      icon = ./icons/fnctl-gitlab.png;
      type = "Application";
      categories = "Documentation";
    })

    (makeDesktopItem {
      name = "io.fnctl.gitlab-issues";
      desktopName = "Fnctl Issues";
      exec = openUrl {
        browserName = gui.defaultApps.browser;
        url = "https://gitlab.com/groups/fnctl/-/issues";
      };
      icon = ./icons/fnctl-issue.png;
      type = "Application";
      categories = "Documentation";
    })
  ];

in {
  config = mkIf (enable && gui.enable) {
    environment.systemPackages = [
      (pkgs.buildEnv {
        name = "fnctl-appitems";
        paths = appItems;
      })
    ];
  };
}
