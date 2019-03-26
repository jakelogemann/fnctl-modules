{ config, lib, options, pkgs, ... }:
let
  isEnabled = with config.fnctl2; (enable && programs.git.enable);

  shellAliases = {
    g    = lib.mkForce "git";
    ga   = lib.mkForce "git add";
    gamend   = lib.mkForce "git commit --amend --no-edit";
    gammendit  = lib.mkForce "git commit --amend --edit";
    gb   = lib.mkForce "git branch";
    gbnm = lib.mkForce "git branch --no-merged";
    gci  = lib.mkForce "git commit";
    gcl  = lib.mkForce "git clone";
    gclean  = lib.mkForce "git clean -ffdx";
    gco  = lib.mkForce "git checkout";
    gd   = lib.mkForce "git diff";
    gdc  = lib.mkForce "git diff --cached";
    gds  = lib.mkForce "git diff --staged";
    gdw  = lib.mkForce "git diff --word-diff";
    gg  = lib.mkForce "git grep";
    ggl = lib.mkForce "git grep --line-number";
    gl   = lib.mkForce "git log --oneline";
    glg  = lib.mkForce "git log --graph";
    gll  = lib.mkForce "git log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary --pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";
    glog = lib.mkForce "git log";
    gpl  = lib.mkForce "git pull --rebase";
    gps  = lib.mkForce "git push";
    gpst = lib.mkForce "git push --tags";
    grb  = lib.mkForce "git rebase -i";
    grm  = lib.mkForce "git rm";
    grmc = lib.mkForce "git rm --cached";
    grs  = lib.mkForce "git reset --";
    gs   = lib.mkForce "git status -sb";
    gst  = lib.mkForce "git stash";
    gt   = lib.mkForce "git tag";
  };

in { config = lib.mkIf isEnabled {

  environment.systemPackages = with pkgs; [
    gitAndTools.git
    gitAndTools.lab
    gitAndTools.gitflow
    gitAndTools.grv
    # (fnctlFunc.wrap {
      # name   = "grv";
      # vars   = {};
      # paths  = with pkgs; [ gitAndTools.grv ];
      # script = ''
      #   #!${pkgs.stdenv.shell}
      #   exec grv
      # ''; })
  ];

  programs.fish.shellAliases = shellAliases;
  programs.bash.shellAliases = shellAliases;
  programs.zsh.shellAliases  = shellAliases;

}; }
