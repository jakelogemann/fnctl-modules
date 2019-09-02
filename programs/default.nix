{ config, lib, options, pkgs, ... }: with lib;

let
  isEnabled = with config.fnctl2; (enable);

in {

  imports = [
    ./backup.nix
    ./git.nix
    ./neovim.nix
    ./spotify.nix
    ./tmux.nix
  ];

  config = mkIf isEnabled {

    programs.mtr.enable = true;

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

  };
}
