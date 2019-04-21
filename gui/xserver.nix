{ config, pkgs, lib, ... }: with lib; 
{ config = mkIf (with config.fnctl2; enable && gui.enable) {
  services = { 
    xserver = {
      enable               = mkForce true;
      autorun              = mkForce true;

      layout               = "us";
      xkbOptions           = "ctrl:nocaps,altwin:swap_lalt_lwin";

      libinput             = {
        enable             = true;
        disableWhileTyping = true;
      };

      # Use GDM as the login service with auto-login
      # After boot, the drive must be unencrypted and after
      # sleep/suspend/hibernate, a password is required.
      displayManager       = {
        sddm.enable        = false;
        lightdm.enable     = false;
        gdm                = {
          enable           = true;
          wayland          = false;
          debug            = true;
        };
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
