{ config, lib, pkgs, options, ... }:
with lib;
with (import ./_helpers.nix {inherit config pkgs lib;});
let
  inherit (config.fnctl2) gui;
  inherit (config.fnctl2.gui.i3wm) colors defaultFont defaultFontSize;
in {
  config.environment.etc."i3/config" = lib.mkIf (isEnabled config) { 
    text = lib.concatStringsSep "\n" 
    (

      ["set $mod Mod4"  # Use Super as modifier.
       "floating_modifier $mod"
       "force_focus_wrapping yes"
       "focus_follows_mouse no"
       "mouse_warping output"
       "popup_during_fullscreen smart"
       "force_display_urgency_hint 1000 ms"
       "workspace_auto_back_and_forth yes"
       "show_marks yes"
       "new_window pixel 4"
       "ipc-socket ~/.i3/i3-ipc.sock"
       "font pango:${defaultFont} ${defaultFontSize}"
       "hide_edge_borders smart"
       "smart_borders on"
       "smart_gaps enable"
       "gaps inner ${defaultFontSize}"
       "gaps outer ${defaultFontSize}"] 

    ++ [(builtins.readFile ./config_modes.conf)]
    ++ (builtins.map exec_always gui.i3wm.extraStartupCommands) 
    ++ [
      (exec_always "xrdb -merge /etc/i3/Xresources")
      (exec_always "setxkbmap -option '' -option 'ctrl:nocaps' -option 'altwin:swap_lalt_lwin'")
      (exec_always "xset s off -dpms")  # disable Display Power Management System.

      /* (exec_always "gnome-settings-daemon") */
      (exec_always "pgrep redshift | xargs -n1 kill -9; redshift -o -x; sleep 3; redshift -m randr -b '1.0:0.45' -l '42.99:-71.46' -t '6250:4500'")
      (exec_always "pgrep compton  | xargs -n1 kill -9; sleep 3; compton -f -i 0.85 -e 0.85 -c -D7 -o0.85 -C -r 8")
      (exec_always "pgrep feh      | xargs -n1 kill -9; sleep 3; feh --no-fehbg --bg-fill ${./background.jpg}")
      (exec_always "pgrep dunst    | xargs -n1 kill -9; sleep 3; dunst -config /etc/i3/dunstrc")
      /* Fix a bug in gnome-settings-daemon:
      **   ref: http://feeding.cloud.geek.nz/posts/creating-a-modern-tiling-desktop-environment-using-i3/
      *  (exec_always "dconf write /org/gnome/settings-daemon/plugins/cursor/active false") */
    ]

    ++ (with colors; [
    /* ---------------- *
    ** Theme Settings  **
    * ---------------- */
    /* window class           border             backgr.            text    indicator */
    "client.focused           #${bright.blue}    #${bright.blue}    #${fg}  #${bright.blue}"
    "client.focused_inactive  #${normal.blue}    #${normal.blue}    #${fg}  #${normal.blue}"
    "client.unfocused         #${bg}             #${bg}             #${fg}  #${bg}"
    "client.urgent            #${bright.yellow}  #${normal.yellow}  #${bg}  #${bright.yellow}"
    "client.background        #${bg}"
    /* --------------------- *
    ** Status Bar Settings  **
    * --------------------- */
    "bar {"
    "  position top"
    "  status_command i3status -c /etc/i3/i3status.conf"
    "  colors {"
    "    background   #${colors.bg}"
    "    statusline   #${colors.fg}"
    "    separator    #${colors.bright.black}"
    "    active_workspace     #${normal.blue}    #${bright.blue}    #${fg}"
    "    focused_workspace    #${bright.blue}    #${normal.blue}    #${bg}"
    "    inactive_workspace   #${bg}             #${bg}             #${fg}"
    "    urgent_workspace     #${bright.yellow}  #${normal.yellow}  #${bg}"
    "  }"
    "  workspace_buttons yes"
    "  font \"pango:${defaultFont} ${defaultFontSize}\""
    "}"
  ]) 

  /* --------------------- *
  **      Keybinds        **
  * --------------------- */
  ++ [ "bindsym $mod+1            workspace   1"
       "bindsym $mod+2            workspace   2"
       "bindsym $mod+3            workspace   3"
       "bindsym $mod+4            workspace   4"
       "bindsym $mod+5            workspace   5"
       "bindsym $mod+6            workspace   6"
       "bindsym $mod+7            workspace   7"
       "bindsym $mod+8            workspace   8"
       "bindsym $mod+9            workspace   9"
       "bindsym $mod+0            scratchpad  toggle"
       "bindsym $mod+Tab          workspace   next_on_output"
       "bindsym $mod+grave        workspace   back_and_forth"
       "bindsym $mod+Shift+Tab    workspace   prev_on_output"
       "bindsym $mod+Ctrl+Escape  exit"
       "bindsym $mod+Ctrl+d       floating    toggle"
       "bindsym $mod+Ctrl+f       fullscreen  toggle"
       "bindsym $mod+Ctrl+h       resize      shrink width  4 px or 4 ppt"
       "bindsym $mod+Ctrl+j       resize      grow   height 4 px or 4 ppt"
       "bindsym $mod+Ctrl+k       resize      shrink height 4 px or 4 ppt"
       "bindsym $mod+Ctrl+l       resize      grow   width  4 px or 4 ppt"
       "bindsym $mod+Ctrl+r       reload"
       "bindsym $mod+Escape       ${exec      "i3lock -c ${colors.bg}"}"
       "bindsym $mod+Shift+1      move        workspace 1"
       "bindsym $mod+Shift+2      move        workspace 2"
       "bindsym $mod+Shift+3      move        workspace 3"
       "bindsym $mod+Shift+4      move        workspace 4"
       "bindsym $mod+Shift+5      move        workspace 5"
       "bindsym $mod+Shift+6      move        workspace 6"
       "bindsym $mod+Shift+7      move        workspace 7"
       "bindsym $mod+Shift+8      move        workspace 8"
       "bindsym $mod+Shift+9      move        workspace 9"
       "bindsym $mod+Shift+0      move        scratchpad"
       "bindsym $mod+Shift+h      move        left"
       "bindsym $mod+Shift+j      move        down"
       "bindsym $mod+Shift+k      move        up"
       "bindsym $mod+Shift+l      move        right"
       "bindsym $mod+Shift+q      ${exec      "xkill"}"
       "bindsym $mod+a            ${mode      "App Mode"}"
       "bindsym $mod+backslash    ${mode      "Layout Mode"}"
       "bindsym $mod+e            ${exec      "gnvim"}"
       "bindsym $mod+f            ${exec      "${gui.defaultApps.terminal} -e ranger"}"
       "bindsym $mod+h            focus       left"
       "bindsym $mod+i            split       h"
       "bindsym $mod+q            kill"
       "bindsym $mod+b            bar         mode toggle"
       "bindsym $mod+j            focus       down"
       "bindsym $mod+k            focus       up"
       "bindsym $mod+l            focus       right"
       "bindsym $mod+r            ${exec      (rofi_menu ["-show" "drun"])}"
       "bindsym $mod+space        ${exec      (rofi_menu ["-show" "combi"])}"
       "bindsym $mod+t            ${exec      gui.defaultApps.terminal}"
       "bindsym $mod+v            split       v"
       "bindsym $mod+w            ${exec      gui.defaultApps.browser}" ]
       );
  };
}

