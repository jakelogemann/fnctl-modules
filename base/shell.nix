/* Base shell environment configuration.

  Responsible for defining the base/core aliases, evironment variables and
  shell initialization that other modules may depend on. Wherever possible,
  this configuration should strive to be non-prescriptive and leave specific
  configurations to downstream configurations.

  NOTE: not to be confused with a `shell.nix` file which can
        be used with `nix-shell`.
*/
{ config, lib, pkgs, ... }:
let
  charSet = "en_US.utf8";
  rg = "${pkgs.ripgrep}/bin/rg";

in {
  config = lib.mkIf config.fnctl2.enable {

    time.timeZone      = lib.mkDefault "America/New_York";

    # Set locale.
    i18n = lib.mkForce {
      consoleFont         = "latarcyrheb-sun32"; # 4K screen, use bigger console font
      consoleUseXkbConfig = true;
      defaultLocale       = charSet;
      extraLocaleSettings = {
        LC_ALL            = charSet;
        LC_COLLATE        = charSet;
        LC_CTYPE          = charSet;
        LC_MONETARY       = charSet;
        LC_NUMERIC        = charSet;
        LC_TIME           = charSet;
      };
    };

    environment = {

      variables = {
        LANG    = lib.mkForce charSet;
        LC_ALL  = lib.mkForce charSet;
        /* these serve to overwrite the official NixOS defaults while still
        allowing configuration downstream (thus no lib.mkForce). */
        EDITOR  = "vim";
        PAGER   = "less";
      };

      /* extra commands run at the start of every new shell. */
      shellInit = (lib.concatStringsSep "\n" [
        "[[ \"$TERM\" != \"xterm-kitty\" ]] || export TERM=\"xterm-256color\""
        "source_if_exists(){ test ! -e $1 || source $1 ;}"
        "source_if_exists $HOME/.aliases.local"
      ]);

      /* extra aliases passed to each new shell. */
      shellAliases = {
        l       = "ls -Qv1 --almost-all";
        la      = "ls -Qltukh --almost-all";
        ll      = "ls -Qlkh --almost-all";
        ls      = "ls";
        lt      = "ls --tree";
        rg-nix  = "${rg} -Lit nix -C4";
      };
    };
  };

}
