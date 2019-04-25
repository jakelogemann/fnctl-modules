{ pkgs, lib, ... }: with lib;
rec {
  inherit (lib.generators) toINI;
  isEmptyList = v: (isList v && builtins.length v == 0);
  boolToString = v: (if v then "true" else "false");

  setAttrsToVal = val: attrNames: 
    listToAttrs (map (li: nameValuePair li val) attrNames);

  /* Formats a given value to be a valid entry in GSettings. */
  fmtDconfVal = v:
  if isBool v then (boolToString v)
  else if isString v then "'${v}'"
  else if (isEmptyList v) then "[\"\", nothing]"
  else if (isList v) then "[" + concatMapStringsSep "," fmtDconfVal v + "]"
  else toString v;

  /* executes the proper terminal emulator with the proper
     arguments/environment for a given terminal name. */
   termExec = { termName, cmdStr, workDir ? "~/"}:
   if termName == "kitty" then "kitty -d ${workDir} -- ${cmdStr}"
   else if termName == "alacritty" then "alacritty --working-directory ${workDir} -e ${cmdStr}"
   else "xterm -e ${cmdStr}";

  /* executes the proper terminal emulator with the proper
     arguments/environment for a given terminal name. */
   openUrl = { browserName, url }:
   if browserName == "firefox" then 
    "firefox --new-tab '${url}'"
   else if browserName == "chromium-browser" then 
    "chromium-browser --password-store=gnome '${url}'"
   else "w3m '${url}'";

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
