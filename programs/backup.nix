{ config, lib, options, pkgs, ... }:
let
  isEnabled = with config.fnctl2; (enable && programs.backup.enable);
  hasGui = config.services.xserver.enable;

  /* backupPackages are always installed, system-wide. */
  backupPackages = (with pkgs; [
    bup
  ]);

  /* backupGuiPackages are only installed if X11 is enabled. */
  backupGuiPackages = lib.optionals hasGui (with pkgs; [
    deja-dup
  ]);

in {
  config.environment = lib.mkIf isEnabled {
    systemPackages = backupPackages ++ backupGuiPackages;
 };
}
