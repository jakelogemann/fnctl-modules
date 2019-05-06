{ config, pkgs, lib, ... }: with lib;

let
  inherit (config.fnctl2) enable dev;

in { config = mkIf (enable && dev.enable && dev.kubernetes.enable) {
  environment.systemPackages = (with pkgs; [
    flannel     # Network fabric for containers, designed for Kubernetes
    kail        # Kubernetes log viewer
    kube-prompt # An interactive kubernetes client featuring auto-complete using go-prompt
    kubecfg     # A tool for managing Kubernetes resources as code
    kubectl     # Kubernetes CLI
    kubernetes  # Production-Grade Container Sch ueduling and Managementj
    kubetail    # Bash script to tail Kubernetes logs from multiple pods at the same time
    kubeval     # Validate your Kubernetes configuration files
    minikube    # A tool that makes it easy to run Kubernetes locally
    openshift   # Build, deploy, and manage your applications with Docker and Kubernetes
    skaffold    # Easy and Repeatable Kubernetes Development
  ]);
}; }