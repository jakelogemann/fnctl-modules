{ config, lib, options, pkgs, ... }: with lib;
{ config = mkIf config.fnctl2.enable {
  # Links the /share directory inside of derivations
  # into /run/current-system/sw
  environment.pathsToLink = [
    "/share"
    "/share/zsh"
  ];

  system.autoUpgrade = mkForce { enable  = false; };

  nixpkgs.config = {
    allowUnfree        = true;
    packageOverrides   = pkgs: {
       unstable        = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {
         config        = config.nixpkgs.config;
      };
    };
  };

  documentation = {
    enable      = true;
    man.enable  = true;
    info.enable = true;
    dev.enable  = true;
    doc.enable  = true;
  };

  nix = let
    nix-plugins        = pkgs.nix-plugins.override { nix = config.nix.package; };
    extra-builtins-lib = "${nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so";

  in {

    useSandbox = true;

    autoOptimiseStore = true;

    # Enable automatic garbage collection.
    gc = {
      automatic = true;
      dates     = "03:15";
      options   = "--delete-older-than 30d";
    };

    sshServe = {
      enable = true;
      keys   = [];
    };

    binaryCaches = [
      "https://cache.nixos.org/"
    ];

    allowedUsers = [ "root" ];
    trustedUsers = [ "root" ];

    extraOptions = ''
      extra-builtins-file = ${../extraBuiltins/default.nix}
      gc-keep-derivations = true
      gc-keep-outputs = true
      keep-derivations = true
      keep-outputs = true
      plugin-files = ${extra-builtins-lib}
      tarball-ttl = 86400
    '';
  };
}; }
