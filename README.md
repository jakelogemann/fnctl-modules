NixOS Modules
=============


### Example Usage

Add a file named `repo.nix` to `imports` in your `configuration.nix`.

<details><summary>In `repo.nix` put this:</summary>

```nix
{ config, pkgs, lib, options, ... }@M:
with {
  /* Ensures that the repo is installed by "realizing"
  the outPath value. Then imports it with given fArgs. */
  loadRepo =
  { name
  , fetchArgs, fetcher ? builtins.fetchGit
  , fArgs ? M, fpath ? "default.nix" }:
  let repo = fetcher (fetchArgs // { inherit name; });
  in (import (builtins.toPath "${repo.outPath}/${fpath}") fArgs);
}; {
  imports = [

  (loadRepo {
    name  = "home-manager-git";
    fpath = "default.nix";
    fArgs = { inherit (M) pkgs; };
    fetchArgs = {
      ref = "release-19.03";
      url = "https://github.com/rycee/home-manager.git";
    };
  }).nixos

  (loadRepo {
    name  = "fnctl-nix-functions";
    fpath = "nixos.nix";
    fetchArgs = {
      ref = "main";
      url = "https://github.com/lgmn-io/nix-functions.git";
    };
  })

  (loadRepo {
    name  = "fnctl-nix-overlay";
    fpath = "nixos.nix";
    fetchArgs = {
      ref = "main";
      url = https://github.com/lgmn-io/nixpkgs-overlay.git";
    };
  })

  (loadRepo {
    name  = "fnctl-nixos-modules";
    fpath = "default.nix";
    fetchArgs = {
      ref = "unstable";
      url = "https://github.com/lgmn-io/fnctl-modules.git";
    };
  }) 

]; }
```

</details>
