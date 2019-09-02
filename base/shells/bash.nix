{ config, pkgs, lib, ... }: with lib;
{ config = mkIf config.fnctl2.enable {

  programs.bash = {
    enableCompletion = true;
    shellAliases     = (import ./aliases.nix {inherit config pkgs lib;});

    interactiveShellInit = concatStringsSep "\n" [
      "export PATH=\"$HOME/.cargo/bin:$HOME/.local/bin:$HOME/bin:$PATH\""
      "function source_if_exists(){ test ! -e $1 || source $1 ;}"
      "source_if_exists $HOME/.bashrc.local"
      "source_if_exists $HOME/.aliases.local"
    ];

  };

}; }

