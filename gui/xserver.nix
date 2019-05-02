{ config, pkgs, lib, ... }: with lib;
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

  hardware = {
    opengl.enable = true;
  };

  services = {
    xserver = {
      enable                = mkForce true;
      autorun               = mkForce true;
      exportConfiguration   = mkForce true;
      startDbusSession      = mkForce true;
      updateDbusEnvironment = mkForce true;

      layout               = mkDefault "us";
      xkbOptions           = mkDefault "ctrl:nocaps,altwin:swap_lalt_lwin,terminate:ctrl_alt_bksp";

      libinput             = {
        enable             = true;
        disableWhileTyping = true;
      };

      # Use GDM as the login service with auto-login
      # After boot, the drive must be unencrypted and after
      # sleep/suspend/hibernate, a password is required.
      displayManager       = {
        sddm.enable        = mkForce false;
        lightdm.enable     = mkForce false;
        gdm.enable         = mkForce true;
        gdm.wayland        = mkForce false;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    arandr  /* Minimal X11 display conf tool */
    maim scrot  /* Minimal screenshot util */

    /* Standard X Desktop Utils */
    xdg_utils
    xdg-user-dirs
    slock                 /* Simple/Screen Lock */
    desktop-file-utils
    xsel xclip            /* Clipboards */
    xdo xdotool wmctrl    /* X11 Automation Tools */

    /* Rofi & Friends */
    dmenu rofi rofi-menugen rofi-pass rofi-systemd
  ];

}; }
