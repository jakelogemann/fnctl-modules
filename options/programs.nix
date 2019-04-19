{ config, lib, options, pkgs, ... }:

with lib;
with pkgs.fnctlFunc;

{ options.fnctl2.programs = {

  git = {
    enable = mkEnabledOption "Enable opinionated system-wide git config.";
  };

  tmux = {
    enable = mkEnabledOption "Enable opinionated system-wide tmux config.";
  };

  fish = {
    enable = mkEnabledOption "Enable opinionated system-wide fish config.";
  };

  neovim = {
    enable = mkEnabledOption "Enable opinionated system-wide neovim config.";
  };

  zsh = {
    enable = mkEnabledOption "Enable opinionated system-wide zsh config.";
  };

}; }
