/* FnCtl-OS :: Full Graphics User Interface (GUI)
** ==============================================
** Constraints/Design Goals:
** - Modern/Beautiful Desktop Environment.
**   - Prefers beauty & features over system requirements.
**   - Has animations, a desktop, etc.
** - Accessible to new/casual users.
*/
{ config, lib, options, pkgs, ... }:
let

in { 
  config.fnctl2 = {
    enable = true;
    gui = {
      enable = true;
      gnome.enable = true;
    };
  };
}
