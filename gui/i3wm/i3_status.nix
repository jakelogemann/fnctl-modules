{ config, lib, pkgs, options, ... }:
with (import ./_helpers.nix {inherit config pkgs lib;});

let
  inherit (config.fnctl2) gui;
  inherit (config.fnctl2.gui.i3wm) colors defaultFont defaultFontSize;
in { 
  config.environment.etc."i3/i3status.conf" = lib.mkIf (isEnabled config) { 
    text = (lib.concatStringsSep "\n" [
      "order += \"tztime local\""
      "order += \"volume master\""
      "order += \"battery 0\""
      "order += \"wireless ${gwIface}\""
      "order += \"disk /\""
      "order += \"load\""
      "general {"
      "  colors = true"
      "  interval = 1"
      "}"
      "wireless ${gwIface} {"
      "  format_up = \" %ip \""
      "  format_down = \"${gwIface}\""
      "}"
      "path_exists VPN {"
      "  path = \"/proc/sys/net/ipv4/conf/tun0\""
      "}"
      "tztime local {"
      "  format = \" %H:%M.%S \""
      "}"
      "load {"
      "  format = \"  %5min/5m \""
      "}"
      "disk \"/\" {"
      "  format = \"  %free \""
      "}"
      "volume master {"
      "  format = \" ♪ %volume \""
      "  format_muted = \" MUTED \""
      "  device = \"default\""
      "  mixer = \"Master\""
      "}"

    ]);
  };
}

