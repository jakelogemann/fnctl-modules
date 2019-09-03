/* FnCtl-OS :: Server
** ===================
** Constraints/Design Goals:
** - NO GUI.
** - Remote host, designed to function as a server.
** - Unopinionated (for generic workloads).
*/
{ config, lib, options, pkgs, ... }:
let

in {
  config.fnctl2 = {
    enable = true;
  };
}
