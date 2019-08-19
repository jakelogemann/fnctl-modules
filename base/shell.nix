{ config, lib, pkgs, ... }:
let 
  charSet = "en_US.utf8"; 
  rg = "${pkgs.ripgrep}/bin/rg";

in { 

  config.environment = lib.mkIf config.fnctl2.enable {

    variables = {
      EDITOR =  "vim";
      PAGER =  "less";
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

}
