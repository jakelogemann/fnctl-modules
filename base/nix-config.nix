{ config, lib, options, pkgs, ... }: 

lib.mkIf config.fnctl2.enable {

  environment.pathsToLink = ["/share"];
  nixpkgs.config.allowUnfree = true;

  nix = let
    nix-plugins = pkgs.nix-plugins.override { nix = config.nix.package; };
    extra-builtins-lib = "${nix-plugins}/lib/nix/plugins/libnix-extra-builtins.so";
  in {

    useSandbox = true;

    autoOptimiseStore = true;

    gc = {
      automatic = true;
      dates = "03:15";
      options = "--delete-older-than 7d";
    };

    sshServe = {
      enable = true;
      keys = [];
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
      gc-keep-derivations = true
    '';
  };

}
