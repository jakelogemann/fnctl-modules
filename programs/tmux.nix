{ config, pkgs, lib, ... }:

let
  isEnabled = with config.fnctl2; (enable && programs.tmux.enable);

  inherit (lib) concatStringsSep;
  joinLines = lines: concatStringsSep "\n" lines;
  concatStr = strs: concatStringsSep "" strs;
  block = fg: bg: contents: (concatStr [
    "#[bg=${bg},fg=${fg}]"
    "  " contents "  "
    "#[bg=default,fg=default]"
  ]);

  clockBlock      = block "black" "cyan"    "%H:%M:%S";
  hostBlock       = block "black" "green"   "#H";
  sessionBlock    = block "black" "green"   "#S";
  windowBlock     = block "white" "black"   "#I";

  defaultWinIdBlock         = block "black" "white"  "#I";
  defaultWinNameBlock       = block "white" "black"  "\"#W\"";

  curWinIdBlock   = block "black" "yellow"  "#I";
  curWinNameBlock = block "yellow" "black"   "\"#W\"";

  cmdDocStr = cmd: text: "${cmd} \\; display-message '${text}'";

  plugins = with pkgs.tmuxPlugins; [
    # Note: Order matters here...
    sensible   # Sensible Defaults
    copycat    # Better search in TMUX.
    pain-control  # Easier pane manipulation.
    prefix-highlight  # Highlight when prefix key is hit.
    sessionist  # Session manipulation.
  ];

in lib.mkIf isEnabled {
  environment.systemPackages = with pkgs; [ tmuxp ];

  programs.screen = {
    screenrc = ''
      multiuser on
      acladd normal_user
    '';
  };

  programs.tmux = {
    enable           = true;
    baseIndex        = 1;
    aggressiveResize = true;
    historyLimit     = 9999;
    escapeTime       = 0;
    shortcut         = "b";
    terminal         = "tmux-256color";
    customPaneNavigationAndResize = true;
    extraTmuxConf    = (concatStringsSep "\n" [
      # Add settings for unknown terminal types
      "set -ag terminal-overrides \",xterm-kitty:XTc\""
      "set -ag terminal-overrides \",xterm-termite:XTc\""
      "set -ga terminal-overrides \",xterm-256color:XTc\""

      # Keybinds
      "bind C-b   ${cmdDocStr "last-window" "Go To Last Window"}"
      "bind b     ${cmdDocStr "last-window" "Go To Last Window"}"
      "bind d      detach"
      "bind r      ${cmdDocStr "source-file /etc/tmux.conf" "Config reloaded!"}"
      "bind C-r    ${cmdDocStr "source-file /etc/tmux.conf" "Config reloaded!"}"
      "bind c      new-window -c '#{pane_current_path}'"
      "bind C      command-prompt -p 'command:' \"new-window -c '#{pane_current_path}' -n '%1' '%1'\""

      # Window Titles
      "set  -g  mouse              on"
      "set  -g  set-titles         on"
      "set  -g  display-time       1000"
      "set  -g  set-titles-string  '#S @ #H :: #W'"
      "set  -g  word-separators   '-@'"
      "set  -g  activity-action   other"
      "setw -g  automatic-rename  on"
      "set  -g  renumber-windows  on"
       # Disable Bells/Notifications
      "set  -g  visual-activity   off"
      "set  -g  escape-time 50"
      "setw -g  alternate-screen on"
      "setw -g  monitor-activity  on"
      "set -g   visual-bell       on"
      "set -g   visual-silence    off"
      "set -g   bell-action       none"
      # Theming / Aesthetics
      "set  -g  clock-mode-colour             brightblue"
      # "set  -g  clock-mode-style              24"
      "set  -g  display-panes-active-colour   cyan"
      "set  -g  display-panes-colour          black"
      "set  -g  message-attr                  bright"
      "set  -g  message-bg                    default"
      "set  -g  message-fg                    default"
      "set  -g  mode-attr                     bright"
      "set  -g  mode-bg                       yellow"
      "set  -g  mode-fg                       black"
      "set  -g  pane-active-border-bg         default"
      "set  -g  pane-active-border-fg         default"
      "set  -g  pane-border-bg                default"
      "set  -g  pane-border-fg                default"
      "set  -g  status-attr                   none"
      "set  -g  status-bg                     black"
      "set  -g  status-fg                     white"
      "set  -g  status-interval               1"
      "set  -g  status-justify                'left'"
      "set  -g  status-position               top"

      "set  -g  status-left                   '${sessionBlock}'"
      "set  -g  status-left-length            40"

      "set  -g  status-right                  '${clockBlock}${hostBlock}'"
      "set  -g  status-right-length           40"

      "setw -g  window-status-activity-attr   bright"
      "setw -g  window-status-bell-attr       bright"
      "setw -g  window-status-current-attr    bold"
      "setw -g  window-status-attr            dim"

      "setw -g  window-status-current-format  '${curWinIdBlock}${curWinNameBlock}'"
      "setw -g  window-status-format          '${defaultWinIdBlock}${defaultWinNameBlock}'"
      "setw -g  window-status-separator       ''"

      # Load plugins!
      (lib.concatStrings (map (x: "run-shell ${x.rtp}\n") plugins))

    ]);
  };

}
