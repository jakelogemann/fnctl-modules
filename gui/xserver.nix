{ config, pkgs, lib, ... }: with lib; 
{ config = mkIf (with config.fnctl2; enable && gui.enable) {

    services.xserver = {
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

    services.unclutter = {
      enable = true;
      keystroke = true;
    };

    services.packagekit.enable = false;
}; }
