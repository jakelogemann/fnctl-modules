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
            TryExec    = "xdg-open";
            Icon       = "${./icons/fnctl-gitlab.png}";
            Categories = "Documentation";
            Actions    = "Activity;Merges;Issues;Chat;Docs;";
            Exec       = "xdg-open 'https://gitlab.com/fnctl'";
          };
        })

        (generators.toINI {} {
          "Desktop Action Docs" = {
            Name = "Documentation";
            Exec = "xdg-open 'https://docs.fnctl.io'";
          };

          "Desktop Action Merges" = {
            Name = "Merge Requests";
            Exec = "xdg-open 'https://gitlab.com/groups/fnctl/-/merge_requests'";
          };

          "Desktop Action Issues" = {
            Name = "Issues List";
            Exec = "xdg-open 'https://gitlab.com/groups/fnctl/-/issues'";
          };

          "Desktop Action Chat" = {
            Name = "Developer Slack";
            Exec = "xdg-open 'https://jlogemann.fnctl.io/channels/'";
          };

          "Desktop Action Activity" = {
            Name = "Recent Activity";
            Exec = "xdg-open 'https://gitlab.com/groups/fnctl/-/activity'";
          };
        })
      ];
    })
  ];
}; }
