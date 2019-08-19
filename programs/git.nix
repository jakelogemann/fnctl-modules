{ config, lib, options, pkgs, ... }:
let
  isEnabled = with config.fnctl2; (enable && programs.git.enable);
  hasGui = config.services.xserver.enable;

  /* gitPackages are always installed, system-wide. */
  gitPackages = (with pkgs.gitAndTools; [
    git
    lab
    gitflow
    grv
  ]);

  /* gitGuiPackages are only installed if X11 is enabled. */
  gitGuiPackages = lib.optionals hasGui (with pkgs; [
    gource
    gitg
  ]);

in {
  config.environment = lib.mkIf isEnabled {

    systemPackages = gitPackages ++ gitGuiPackages;
    shellAliases = {
      g         = "git";
      ga        = "git add";
      gaddp     = "git add --patch";
      gamend    = "git commit --amend --no-edit";
      gamendit  = "git commit --amend --edit";
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
      gll       = "git log --graph --topo-order --abbrev-commit --date=short --decorate --all --boundary --pretty=format:'%Cgreen%ad %Cred%h%Creset -%C(yellow)%d%Creset %s %Cblue[%cn]%Creset %Cblue%G?%Creset'";
      glog      = "git log";
      gpl       = "git pull --rebase --autostash";
      gps       = "git push";
      gpst      = "git push --tags";
      grb       = "git rebase --autostash --rerere-autoupdate";
      grm       = "git rm -r";
      grmc      = "git rm -r --cached --ignore-unmatch";
      grs       = "git reset --";
      gs        = "git status --short --branch --find-renames --untracked-files";
      gst       = "git stash";
      gt        = "git tag";
    };

  };
}
