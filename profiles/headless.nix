/* FnCtl-OS :: Headless
** ====================
** Constraints/Design Goals:
** - Provides no GUI/packages by default.
** - Configures host to be headless for CI testing.
*/
{ config, lib, options, pkgs, ... }:
let

in {
  config.fnctl2 = {
    enable = true;
  };
}
