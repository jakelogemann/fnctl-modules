{ config, pkgs, lib, options, ... }: with lib;
let
  inherit (config.fnctl2) enable dev gui;
in { config = mkIf (enable && dev.enable) {

  nixpkgs.config = {
    allowUnfree        = lib.mkForce true;
    packageOverrides   = pkgs: {
       unstable        = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) {
         config        = config.nixpkgs.config;
      };
    };
  };

  # General Development
  environment.systemPackages = (with pkgs; [

    # Terminal / Shell tools
    direnv     # Automatically load env vars in dirs
    time       # Tool that runs programs and summarizes the system resources they use

    # Dev tools
    shellcheck # Basic script checking
    gnumake    # A tool to control the generation of non-source files from sources
    unstable.gitAndTools.lab   # GitLab CLI
    mkdocs     # Project documentation with Markdown

  ]) ++ (optionals gui.enable (with pkgs; [

    # GUI dev tools
    postman    # API Development Environment
    gource     # A Software verspuion control visualization tool
    zeal       # Docs Viewer (a la Dash on OS X)

  ])) ++ (optionals dev.ansible.enable (with pkgs; [

    # Ansible
    ansible       # A simple automation tool
    ansible-lint  # Best practices checker for Ansible

  ])) ++ (optionals dev.go.enable (with pkgs; [

    # Golang
    go       # The Go programming language
    gocode   # An autocompletion daemon for the Go programming language
    dep      # Go dependency management tool
    dep2nix  # Convert `Gopkg.lock` files from golang dep into `deps.nix`
    go-tools # A collection of tools and libraries for working with Go code, including linters and static analysis
    gopkgs   # Tool to get list available Go packages
    gotests  # Generate Go tests from source code
    gosec    # Golang security checker

  ])) ++ (optionals dev.python.enable (with pkgs; [

    # # Python
    # pypi2nix
    # python3Full
  ]));

  # Golang
  environment.variables = (mkIf dev.go.enable {
    GOROOT = [
      "${pkgs.go.out}/share/go"
    ];
  });
}; }