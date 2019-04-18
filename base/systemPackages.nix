{ config, lib, options, pkgs, ... }: 

lib.mkIf config.fnctl2.enable {

  programs.bash = {
    enableCompletion = lib.mkDefault true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    zsh-autoenv.enable = true;
    autosuggestions.enable = true;
    autosuggestions.strategy = "match_prev_cmd";
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
      customPkgs = with pkgs; [
        nix-zsh-completions
      ];
      plugins = [
        "colored-man-pages"
        "dirpersist"
        "extract"
        "pass"
        "pip"
        "postgres"
        "python"
        "colorize"
      ];
    };

  };

  environment.systemPackages = with pkgs; [
    cacert
    # kexec-tools  # Tools related to the kexec Linux feature
    android-udev-rules # Allows android MTP devices to be connected.
    logitech-udev-rules # Allows Logitech devices to be (properly) connected.
  ];
}
