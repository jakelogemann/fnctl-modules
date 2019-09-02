{ config, lib, options, pkgs, ... }: with lib;

let
  mkOptionalDependency = {
    name, repoUrl, repoRef, enabledByDefault ? true,
  }: {
    enable  = mkOption {
      description = "enable optional dependency: ${name}";
      default = enabledByDefault;
      type = types.bool;
    };

    repoUrl = mkOption {
      description = "GIT repository url for ${name}";
      default     = repoUrl;
      type        = types.str;
    };

    repoRef = mkOption {
      description = "";
      default     = repoRef;
      type        = types.str;
    };
  };

in {

  options.fnctl2 = {
    enable = mkEnableOption "Enable the FnCtl modules.";

    pkgs-overlay = mkOptionalDependency {
      name    = "fnctl-pkgs-overlay";
      repoRef = "master";
      repoUrl = "ssh://git@gitlab.com/fnctl-nix/pkgs-overlay.git";
    };

    home-manager = mkOptionalDependency {
      name    = "home-manager-git";
      repoRef = "release-19.03";
      repoUrl = "https://github.com/rycee/home-manager.git";
    };

    functions-lib = mkOptionalDependency {
      name    = "fnctl-nix-functions-lib";
      repoRef = "master";
      repoUrl = "ssh://git@gitlab.com/fnctl-nix/functions.git";
    };

  };

  imports = [
    ./networking.nix
    ./programs.nix
    ./gui.nix
    ./gui_i3wm.nix
    ./gui_gnome.nix
    ./dev.nix
  ];

}
