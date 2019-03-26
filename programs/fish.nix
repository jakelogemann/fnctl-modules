{ config, pkgs, lib, ... }:
let
  isEnabled = with config.fnctl2; (enable && programs.fish.enable);
  inherit (lib) concatStringsSep mkForce mkDefault;
  joinLines = concatStringsSep "\n";
  linesToString = concatStringsSep "\\n";

  aliasesAsAbbrs = (joinLines (lib.mapAttrsToList (
    n: v: "abbr -a -g ${n} ${v}"
  ) config.environment.shellAliases));

in lib.mkIf isEnabled {

  # Dirty hack because fish completion generation was broken. See also:
  # https://github.com/NixOS/nixpkgs/commit/029adf961995c69fe929fa7dcf5e67582ff2c0f7
  environment.etc."fish/generated_completions".enable = lib.mkForce false;

  programs.fish = {
    enable = true;

    interactiveShellInit = mkForce (joinLines [
      "bind \\cw backward-kill-word    #Make Ctrl-W work like bash."
      "abbr -a -g pass gopass"
      "abbr -a -g rebuild sudo fnctl-rebuild"
      "abbr -a -g upgrade sudo fnctl-upgrade"
      "abbr -a -g repl sudo fnctl-repl"
      "abbr -a -g nrbs sudo nixos-rebuild --show-trace switch"
      "abbr -a -g nrbt sudo nixos-rebuild --show-trace test"
      "abbr -a -g nrbb sudo nixos-rebuild --show-trace boot"
      aliasesAsAbbrs
    ]);

    shellInit = ''
    set -U fish_greeting

    if not functions -q fisher
      set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
      curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
      touch $XDG_CONFIG_HOME/fish/fishfile
      fish -c fisher
    end
    '';
  };
}

