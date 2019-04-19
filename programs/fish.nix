{ config, pkgs, lib, ... }:
let
  isEnabled = with config.fnctl2; (enable && programs.fish.enable);
  inherit (lib) concatStringsSep mkForce mkDefault;
  joinLines = concatStringsSep "\n";
  linesToString = concatStringsSep "\\n";

  fish = rec {
    mkGlobalAlias = name: command: "abbr -a -g -- ${name} ${command}";
    mkGlobalAliasFromAttrs = as: joinLines (lib.mapAttrsToList mkGlobalAlias as);
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

  aliasesAsAbbrs = fish.mkGlobalAliasFromAttrs config.environment.shellAliases;

in lib.mkIf isEnabled {

  # Dirty hack because fish completion generation was broken. See also:
  # https://github.com/NixOS/nixpkgs/commit/029adf961995c69fe929fa7dcf5e67582ff2c0f7
  environment.etc."fish/generated_completions".enable = lib.mkForce false;

  programs.fish = {
    enable = true;

    shellInit = joinLines [
      "set -U fish_greeting"
      "set -g NVIM_LISTEN_ADDRESS ~/.local/share/nvim/current.socket"
      (fish.mkGlobalMap "\\cw" "backward-kill-word") #Make Ctrl-W work like bash.
      (fish.mkGlobalMap "\\cj" "down-or-search")
      (fish.mkGlobalMap "\\ck" "up-or-search")
      (fish.mkGlobalMap "\\cl" "execute")
      (fish.mkGlobalMap "\\ch" "backward-kill-line")
      (fish.mkGlobalAlias "pass" "gopass")
      (fish.mkGlobalAlias "current-system" "cd /run/current-system")
      (fish.mkGlobalAlias "booted-system" "cd /run/booted-system")
      (fish.mkGlobalAlias "rebuild-system" "sudo nixos-rebuild --show-trace --fast switch")
      (fish.mkGlobalAlias "upgrade-system" "sudo nixos-rebuild --show-trace --upgrade switch")
      (fish.mkGlobalAlias "update-system"  "sudo nix-channel --update nixos")
      (fish.mkGlobalAlias "repl"           "sudo fnctl-repl")
      (fish.mkGlobalAlias "nrbs"           "sudo nixos-rebuild --show-trace switch")
      (fish.mkGlobalAlias "nrbt"           "sudo nixos-rebuild --show-trace test")
      (fish.mkGlobalAlias "dry-build"      "sudo nixos-rebuild --show-trace --fast dry-build")
      (fish.mkGlobalAlias "dry-activate"   "sudo nixos-rebuild --show-trace --fast dry-activate")
      (fish.mkGlobalAlias "nrbb"           "sudo nixos-rebuild --show-trace boot")
      (fish.mkGlobalAlias "nrbs"           "sudo nixos-rebuild --show-trace switch")
      (fish.mkGlobalAlias "ns"             "nix-shell")
      (fish.mkGlobalAlias "nsp"            "nix-shell --pure")
      (fish.mkGlobalAlias "nrepl"          "nix repl")
      fish.installFisher
    ];
  };
}

