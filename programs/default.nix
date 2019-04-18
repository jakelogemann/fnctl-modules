{ config, lib, options, pkgs, ... }: with lib;

let
  isEnabled = with config.fnctl2; (enable);

in {

  imports = [
    ./fish.nix
    ./git.nix
    ./neovim.nix
    ./tmux.nix
    ./zsh.nix
  ];

  config = mkIf isEnabled {

    programs.mtr.enable = true;

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  };
}

