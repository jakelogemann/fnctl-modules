{ config, pkgs, lib, ... }: with lib;
with (import ../gnome/_helpers.nix { inherit pkgs lib; });
let
  inherit (config.fnctl2) enable gui;

in { config.environment = mkIf (enable && gui.enable) {
  systemPackages = with pkgs; [
    (writeTextFile {
      name = "fnctl-dev.desktop";
      destination = "/share/applications/fnctl-dev.desktop";
      text = concatStringsSep "\n" [
        (generators.toINI {} {
          "Desktop Entry" = {
            Type       = "Application";
            Name       = "FnCtl.dev";
            Terminal   = false;
            # TryExec    = gui.defaultApps.browser;
            Icon       = "${./icons/fnctl-gitlab.png}";
            Categories = "Documentation";
            Actions    = "Activity;Merges;Issues;Chat;Docs;";

            Exec = openUrl {
              browserName = gui.defaultApps.browser;
              url = "https://gitlab.com/fnctl";
            };
          };
        # })

        # (generators.toINI {} {
          "Desktop Action Docs" = {
            Name = "Documentation";
            Exec = openUrl {
              browserName = gui.defaultApps.browser;
              url = "https://docs.fnctl.io";
            };
          };

          "Desktop Action Merges" = {
            Name = "Merge Requests";
            Exec = openUrl {
              browserName = gui.defaultApps.browser;
              url = "https://gitlab.com/groups/fnctl/-/merge_requests";
            };
          };

          "Desktop Action Issues" = {
            Name = "Issues List";
            Exec = openUrl {
              browserName = gui.defaultApps.browser;
              url = "https://gitlab.com/groups/fnctl/-/issues";
            };
          };

          "Desktop Action Chat" = {
            Name = "Developer Slack";
            Exec = openUrl {
              browserName = gui.defaultApps.browser;
              url = "https://jlogemann.fnctl.io/channels/";
            };
          };

          "Desktop Action Activity" = {
            Name = "Recent Activity";
            Exec = openUrl {
              browserName = gui.defaultApps.browser;
              url = "https://gitlab.com/groups/fnctl/-/activity";
            };
          };
        })
      ];
    })
  ];
}; }
