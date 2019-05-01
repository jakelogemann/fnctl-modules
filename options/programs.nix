{ config, lib, options, pkgs, ... }:

with lib;
with pkgs.fnctlFunc;

{ options.fnctl2.programs = {

  git = {
    enable = mkEnabledOption "Enable opinionated system-wide git config.";
  };

  spotify = {
    enable = mkDisabledOption "Enable spotify system-wide.";
  };

  tmux = {
    enable = mkEnabledOption "Enable opinionated system-wide tmux config.";
  };

  fish = {
    enable = mkDisabledOption "Enable opinionated system-wide fish config.";
  };

  neovim = {
    enable = mkDisabledOption "Enable opinionated system-wide neovim config.";
  };

  zsh = {
    enable = mkDisabledOption "Enable opinionated system-wide zsh config.";
  };

}; }
