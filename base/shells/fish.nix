{ config, pkgs, lib, ... }: with lib;

let 
  fish = rec {
    mkGlobalAlias = name: command: "abbr -a -g -- ${name} ${command}";
    mkGlobalAliasFromAttrs = as: concatStringsSep "\n" (mapAttrsToList mkGlobalAlias as);
    installFisher = ''
    if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    touch $XDG_CONFIG_HOME/fish/fishfile
    fish -c fisher
    end
    '';
    mkGlobalMap = key: cmd: ''
    bind ${key} ${cmd}
    bind -M insert ${key} ${cmd}
    '';
  };
in { 

  config = mkIf config.fnctl2.enable {

    /* Dirty hack because fish completion generation was broken. 
    ** See also: https://github.com/NixOS/nixpkgs/commit/029adf961995c69fe929fa7dcf5e67582ff2c0f7  **/
    environment.etc."fish/generated_completions".enable = mkForce false;

    programs.fish = {
      enable = true;
      shellAliases = (import ./aliases.nix {inherit config pkgs lib;});
      shellInit = concatStringsSep "\n" [
        "set -U fish_greeting"
        "set -g NVIM_LISTEN_ADDRESS ~/.local/share/nvim/current.socket"
        (fish.mkGlobalMap "\\cw" "backward-kill-word") #Make Ctrl-W work like bash.
        (fish.mkGlobalMap "\\cj" "down-or-search")
        (fish.mkGlobalMap "\\ck" "up-or-search")
        (fish.mkGlobalMap "\\cl" "execute")
        (fish.mkGlobalMap "\\ch" "backward-kill-line")
        fish.installFisher
      ];
    };

  }; 
}

