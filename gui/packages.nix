{ config, pkgs, lib, ... }: with lib; 
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  environment.systemPackages = with pkgs; [
    firefox thunderbird   # <3 Mozilla <3
    kitty                 # Modern terminal application
    arandr

    # Standard X Desktop Utils
    xdg_utils xdg-user-dirs slock
    desktop-file-utils
    xsel xclip xdo xdotool wmctrl

    # Rofi & Friends
    dmenu rofi rofi-menugen rofi-pass rofi-systemd

  ];

}; }
