{ config, pkgs, lib, ... }: with lib;
{ config = mkIf config.fnctl2.enable {

  programs.zsh = {
    enable                    = true;
    enableCompletion          = true;
    zsh-autoenv.enable        = true;
    shellAliases              = (import ./aliases.nix {inherit config pkgs lib;});

    autosuggestions = {
      enable    = true;
      strategy  = "match_prev_cmd";
    };

    syntaxHighlighting = {
      enable = true;
      highlighters = [
        "main"
        "brackets"
        "cursor"
        "pattern"
        "root"
        "line"
      ];
      /*
      Specifies custom patterns to be highlighted by zsh-syntax-highlighting.
      Please refer to the docs for more information about the usage:
      https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/pattern.md
      */ patterns = {
        "sudo" = "fg=yellow,bold";
      };
    };

    /* Enable execution of compinit call for all interactive zsh shells. This
     * option can be disabled if the user wants to extend its fpath and a custom
     * compinit call in the local config is required. */
    enableGlobalCompInit = true;

    interactiveShellInit = concatStringsSep "\n" [
      "[[ \"$TERM\" != \"xterm-kitty\" ]] || export TERM=\"xterm-256color\""
      "path+=( $HOME/.cargo/bin $HOME/.local/bin $HOME/bin )"
      "function source_if_exists(){ test ! -e $1 || source $1 ;}"
      "source_if_exists $HOME/.zshrc.local"
      "source_if_exists $HOME/.aliases.local"
    ];

    ohMyZsh = {
      enable     = true;
      theme      = "miloshadzic";
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

}; }

