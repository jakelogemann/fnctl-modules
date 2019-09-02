{ config, pkgs, lib, ... }: with lib; {
  imports = [
    ./bash.nix
    ./fish.nix
    ./zsh.nix
  ]; 

  config = mkIf config.fnctl2.enable {
    programs.command-not-found.enable = true;

    programs.less = {
      enable = true;

      commands.h = "noaction 5e("; 
      commands.l = "noaction 5e)"; 

      envVariables.LESS = concatStringsSep " " [
        "--quit-if-one-screen"
        "--quit-on-intr"
        "--squeeze-blank-lines"
        "--clear-sceen"
        "--hilite-unread"
        "--RAW-CONTROL-CHARS"
        "--SEARCH-SKIP-SCREEN"
      ]; 

      lineEditingKeys.q = "abort"; 

    };

  };
}
