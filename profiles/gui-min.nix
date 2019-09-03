/* FnCtl-OS :: Minimal Graphics User Interface (GUI)
** =================================================
** Constraints/Design Goals:
** - Modern/FAST/STABLE Desktop Environment.
**   - Prefers efficiency & ergonomics over flashy aesthetics.
**   - Minimizes hardware resource usage to allow for heavier workloads.
**   - Has very few animations.
**   - Usable with ONLY keyboard OR mouse.
** - Configurable for professionals/power-users.
*/
{ config, lib, options, pkgs, ... }:
let

in { 
  config.fnctl2 = {
    enable = true;
    gui = {
      enable = true;
      i3wm.enable = true;
    };
  };
}
