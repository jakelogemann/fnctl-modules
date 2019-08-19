{ config, lib, options, pkgs, ... }:
let
  isEnabled = with config.fnctl2; (enable && programs.zsh.enable);

in {
  config = lib.mkIf isEnabled {

    programs.zsh = {
      enable                    = true;
      enableCompletion          = true;
      zsh-autoenv.enable        = true;
      autosuggestions.enable    = true;
      autosuggestions.strategy  = "match_prev_cmd";
      syntaxHighlighting.enable = true;
      shellInit = lib.concatStringsSep "\n" [
        "path+=( $HOME/.cargo/bin $HOME/.local/bin $HOME/bin )"
        "function source_if_exists(){ test ! -e $1 || source $1 ;}"
        "source_if_exists $HOME/.zshrc.local"
        "source_if_exists $HOME/.aliases.local"
      ];
      # promptInit = "autoload -U promptinit && promptinit && prompt adam1";

      ohMyZsh = {
        enable     = true;
        theme      = "agnoster";
        customPkgs = with pkgs; [
          nix-zsh-completions
        ];
        plugins = [
          "colored-man-pages"
          "dirpersist"
          "extract"
          "pass"
          "pip"
          "postgres"
          "python"
          "colorize"
        ];
      };

    };

  };
}
