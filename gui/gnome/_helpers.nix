{ pkgs, lib, ... }: with lib;
rec {
  inherit (lib.generators) toINI;
  isEmptyList = v: (isList v && builtins.length v == 0);
  boolToString = v: (if v then "true" else "false");
  isTuple = v: ((builtins.match ".*([\(].+[\)]).*" (toString v)) != null);

  setAttrsToVal = val: attrNames:
    listToAttrs (map (li: nameValuePair li val) attrNames);

  /* Formats a given value to be a valid entry in GSettings. */
  fmtDconfVal = v:
  if isBool v then (boolToString v)
  else if (isString v && !isTuple v) then "'${v}'"
  else if (isEmptyList v) then "[\"\", nothing]"
  else if (isList v) then "[" + concatMapStringsSep "," fmtDconfVal v + "]"
  else if (isTuple v) then (builtins.head (builtins.match "\((.+)\)" (toString v)))
  else toString v;

  /* executes the proper terminal emulator with the proper
     arguments/environment for a given terminal name. */
   termExec = { termName, cmdStr, workDir ? "~/"}:
   if termName == "kitty" then "kitty -d ${workDir} -- ${cmdStr}"
   else if termName == "alacritty" then "alacritty --working-directory ${workDir} -e ${cmdStr}"
   else builtins.abort "Unsupported terminal: ${termName}";

  /* executes the proper text editor with the proper
     arguments/environment for a given editor name. */
   openEditor = { editor, path ? "~/" }:
   if editor == "code" then "code --wait --new-window ${path}"
   else if editor == "nvim" then
    (concatStringSep " " ["alacritty" "--title 'NeoVim :: ${path}'" "--class 'NeoVim'" "--command 'nvim ${path}'"])
   else builtins.abort "Unsupported editor: ${editor}";

  /* executes the proper terminal emulator with the proper
     arguments/environment for a given terminal name. */
   openUrl = { browserName, url }:
   if browserName == "firefox" then
    "firefox --new-tab '${url}'"
   else if browserName == "chromium-browser" then
    "chromium-browser --password-store=gnome '${url}'"
   else builtins.abort "Unsupported browser: ${browser}";

  /* Generates a DConf-style INI file from attributes of the form:

  Example Usage:
  ```
  toDconf {
  "org/gnome/settings-daemon/plugins/xsettings" = {
  antialiasing = "grayscale";
  hinting = "slight";
  };
  }
  ```*/
  toDconf = toINI {
    mkKeyValue = key: value: "${key}=${fmtDconfVal value}";
  };

}
