{ config, lib, pkgs, ... }:
{
  config = lib.mkIf config.fnctl2.enable {

    time.timeZone      = lib.mkDefault "America/New_York";
    i18n.consoleFont   = lib.mkDefault "Lat2-Terminus16";
    i18n.consoleKeyMap = lib.mkDefault "us";
    i18n.defaultLocale = lib.mkDefault "en_US.UTF-8";

    environment.shellInit = (lib.concatStringsSep "\n" [
      "[[ \"$TERM\" != \"xterm-kitty\" ]] || export TERM=\"xterm-256color\""
    ]);

  };
}
