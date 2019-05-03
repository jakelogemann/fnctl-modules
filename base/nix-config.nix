{ config, lib, options, pkgs, ... }:

lib.mkIf config.fnctl2.enable {

  # Links the /share directory inside of derivations
  # into /run/current-system/sw
  environment.pathsToLink = [
    "/share"
    "/share/zsh"
  ];

  nixpkgs.config.allowUnfree = true;

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
      plugin-files = ${extra-builtins-lib}
      extra-builtins-file = ${../extraBuiltins/default.nix}
      gc-keep-outputs = true
      tarball-ttl = 86400
      gc-keep-derivations = true
    '';
  };

}
