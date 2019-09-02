{ config, pkgs, lib, ... }: { 

  mkdir     = "mkdir -pv";
  ga        = "git add";
  gamend    = "git commit --amend --no-edit";
  gammendit = "git commit --amend --edit";
  gb        = "git branch";
  gbnm      = "git branch --no-merged";
  gci       = "git commit";
  gcl       = "git clone";
  gclean    = "git clean -ffdx";
  gco       = "git checkout";
  gd        = "git diff";
  gdc       = "git diff --cached";
  gds       = "git diff --staged";
  gdw       = "git diff --word-diff";
  gg        = "git grep";
  gl        = "git log --oneline";
  glg       = "git log --graph";
  gll       = "git log --graph --topo-order --abbrev-commit --date = short --decorate --all --boundary --pretty = format:\"%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset\"";
  glog      = "git log";
  gpl       = "git pull --rebase";
  gps       = "git push";
  gpst      = "git push --tags";
  grb       = "git rebase -i";
  grm       = "git rm";
  grmc      = "git rm --cached";
  grs       = "git reset --";
  gs        = "git status -sb";
  gst       = "git stash";
  gt        = "git tag";

}
