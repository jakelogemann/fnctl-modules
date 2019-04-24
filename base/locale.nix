{ config, lib, pkgs, ... }:
let charSet = "en_US.utf8"; in {
  config = lib.mkIf config.fnctl2.enable {

    time.timeZone      = lib.mkDefault "America/New_York";

    # Set locale.
    i18n = lib.mkForce {
      consoleFont         = "latarcyrheb-sun32"; # 4K screen, use bigger console font
      consoleUseXkbConfig = true;
      defaultLocale = charSet;
      extraLocaleSettings = {
        LC_ALL            = charSet;
        LC_COLLATE        = charSet;
        LC_CTYPE          = charSet;
        LC_MONETARY       = charSet;
        LC_NUMERIC        = charSet;
        LC_TIME           = charSet;
      };
    };
    environment.variables.LANG          = lib.mkForce charSet;
    environment.sessionVariables.LANG   = lib.mkForce charSet;
    environment.variables.LC_ALL        = lib.mkForce charSet;
    environment.sessionVariables.LC_ALL = lib.mkForce charSet;

    environment.shellInit = (lib.concatStringsSep "\n" [
      "[[ \"$TERM\" != \"xterm-kitty\" ]] || export TERM=\"xterm-256color\""
    ]);

  };
}
