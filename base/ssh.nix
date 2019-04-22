
{ config, lib, pkgs, ... }:
let
  enabled = config.fnctl2.enable;

in with lib; {
  config = lib.mkIf enabled {

    ## Enable Extra Auth Methods.
    hardware.u2f.enable             = mkForce true;
    security.pam.enableSSHAgentAuth = mkForce true;
    security.pam.enableEcryptfs     = mkForce true;
    # security.pam.u2f.enable         = mkForce true;
    security.pam.usb.enable         = mkForce false;

    # Enable SSH recovery for failed boot.
    boot.initrd.network.ssh.enable = true;

    ## Enable OpenSSH Server Access.
    services.openssh = {
      enable                 = true;
      openFirewall           = true;

      # Root is too powerful to risk exposing via SSH.
      permitRootLogin        = "no";

      # X11 isn't enabled, so it isnt allowed to be forwarded.
      forwardX11             = false;

      # Do not trust manually added SSH keys for any user.
      authorizedKeysFiles    = [ "/etc/ssh/authorized_keys.d/%u" ];

      # Passwords are not sufficient authentication. Ever.
      passwordAuthentication = false;

      # U2F / 2FA devices often use this.
      challengeResponseAuthentication = true;
    };

    ## Prevent SSH Brute Force Attacks
    services.sshguard = {
      enable           = false;
      attack_threshold = 30;
      whitelist        = [ ];
    };

  };
}
