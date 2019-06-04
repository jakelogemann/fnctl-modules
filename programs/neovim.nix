{ config, lib, options, pkgs, ... }: with lib;

let
  isEnabled = with config.fnctl2; (enable && programs.neovim.enable);

  neovimPkg = pkgs.neovim.override {
    vimAlias = true;
    viAlias  = true;
    withNodeJs = true;
    withRuby = true;
    withPython3 = true;
    extraPython3Packages = (pyPkgs: with pyPkgs; [

    ]);
  };

  EDITOR = "${neovimPkg}/bin/nvim";

  shellAliases = {
    e    = mkForce EDITOR;
    edit = mkForce EDITOR;
    vi   = mkForce EDITOR;
    vim  = mkForce EDITOR;
  };

in mkIf isEnabled {

  programs.fish.shellAliases = shellAliases;
  programs.bash.shellAliases = shellAliases;
  programs.zsh.shellAliases  = shellAliases;

  environment.variables.EDITOR = mkForce EDITOR;

  environment.systemPackages = with pkgs; [
    neovimPkg neovim-remote
  ];

}
