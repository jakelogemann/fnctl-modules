{ config, pkgs, lib, ... }: 

with lib; 
let 
  inherit (config.fnctl2) gui;
  inherit (config.fnctl2.gui.i3wm) colors defaultFont;

in rec {
  isEmptyList = v: (isList v && builtins.length v == 0);
  boolToString = v: (if v then "true" else "false");
  isTuple = v: ((builtins.match ".*([\(].+[\)]).*" (toString v)) != null);

  setAttrsToVal = val: attrNames:
    listToAttrs (map (li: nameValuePair li val) attrNames);

  isEnabled = config: builtins.all (x: x) (with config.fnctl2; [
    enable 
    gui.enable
    gui.i3wm.enable
  ]);

  exec = cmd: "exec \"${cmd}\"";
  mode = name: "mode \"${name}\"";
  exec_always = cmd: "exec_always \"${cmd}\"";
  rofi_menu = args:
  lib.concatStringsSep " " ([
    "rofi"
    "-async-pre-read 50"
    "-click-to-exit"
    "-combi-modi drun,ssh,run,window"
    "-display-combi ALL"
    "-display-drun APP"
    "-display-run EXEC"
    "-display-ssh SSH"
    "-display-window WIN"
    "-drun-display-format '  <b>{name}</b>  <small>{comment}</small>'"
    "-drun-match-fields name,exec,comment,categories,generic"
    "-drun-show-actions"
    "-location 2"
    "-markup-rows"
    "-matching fuzzy"
    "-modi drun,ssh,run,window,combi"
    "-no-config"
    "-no-lazy-grab"
    "-only-match"
    "-padding 8"
    "-parse-hosts"
    "-parse-known-hosts"
    "-scroll-method 1"
    "-show-icons"
    "-sort"
    "-terminal ${gui.defaultApps.terminal}"
    "-tokenize"
    "-window-format '  {c}    {t}'"
  ] ++
  (let
    window_colors = { background, border, separator }:
      "-color-window '#${background},#${border},#${separator}'";
    row_colors = kind: { background, foreground, background_alt, highlight_background, highlight_foreground}:
      "-color-${kind} '#${background},#${foreground},#${background_alt},#${highlight_background},#${highlight_foreground}'";

  in with colors; [
    (window_colors {
      background = colors.bg;
      border     = colors.bg;
      separator  = normal.white;
    })
    (row_colors "normal" {
      background           = colors.bg;
      foreground           = colors.fg;
      background_alt       = colors.bg;
      highlight_background = normal.black;
      highlight_foreground = normal.green;
    })
    (row_colors "urgent" {
      background           = bright.yellow;
      foreground           = normal.black;
      background_alt       = normal.yellow;
      highlight_background = normal.green;
      highlight_foreground = normal.black;
    })
    (row_colors "active" {
      background           = normal.black;
      foreground           = normal.white;
      background_alt       = normal.black;
      highlight_background = normal.green;
      highlight_foreground = normal.black;
    })
  ]) ++ args);

  gwIface = "wlp2s0"; /* TODO: this interface is hard-coded. */
}
