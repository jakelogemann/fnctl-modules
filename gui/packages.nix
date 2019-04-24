{ config, pkgs, lib, ... }: with lib;
let
  inherit (config.fnctl2) enable gui;
in { config = mkIf (enable && gui.enable) {

  environment.variables."TERM" = mkForce gui.defaultApps.terminal;
  environment.variables."VISUAL" = mkForce gui.defaultApps.editor;
  environment.sessionVariables."TERM" = gui.defaultApps.terminal;
  environment.sessionVariables."VISUAL" = gui.defaultApps.editor;

  environment.systemPackages = with pkgs; [
    arandr  /* Minimal X11 display conf tool */

    /* Standard X Desktop Utils */
    xdg_utils xdg-user-dirs slock
    desktop-file-utils
    xsel xclip xdo xdotool wmctrl

    /* Rofi & Friends */
    dmenu rofi rofi-menugen rofi-pass rofi-systemd

    /* Terminal Emulator(s)
    * TODO: This should be parameterized. */
    kitty         /* Modern & full-featured */
    alacritty     /* Modern, minimal & rust */

    /* Mail Reader(s)
    * TODO: This should be parameterized. */
    thunderbird /* <3 Mozilla <3 */

    /* Instant Messaging Client(s)
    * TODO: This should be parameterized. */
    (pidgin-with-plugins.override {
      plugins = [
        purple-plugin-pack
        purple-hangouts
        pidgin-otr
        pidgin-window-merge
      ];
    })
    slack
    signal-desktop

    /* Web Browser(s)
    TODO: This should be parameterized. */
    firefox    /* <3 Mozilla <3 */
    chromium   /* Google-free web browser */

    /* Peer to Peer Client(s)
    TODO: This should be parameterized. */
    deluge

    /* Office Productivity Suite(s)
    TODO: This should be parameterized. */
    libreoffice-fresh
    dia   # Diagram tool

    /* Design Suite(s)
    TODO: This should be parameterized. */
    gimp 
    blender
    inkscape

    /* EXPERIMENTAL:
    Everything below here is entirely experimental and totally able to be
    removed safely. */
    focuswriter  /* Distraction free scratchpad */
    liferea      /* RSS/Atom News Reader */

  ];

  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark-qt;
  };

}; }
