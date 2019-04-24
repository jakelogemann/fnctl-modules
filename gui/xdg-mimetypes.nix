{ config, pkgs, lib, ... }: 
with lib;
with import ./gnome/_helpers.nix { inherit pkgs lib; };

let 
  inherit (config.fnctl2) enable gui; 

  codeTypes = (setAttrsToVal "code.desktop" [
    "application/x-perl"
    "text/x-patch"
    "text/html"
    "text/mathml"
    "text/plain"
    "text/x-c++hdr"
    "text/x-c++src"
    "text/x-chdr"
    "text/x-csrc"
    "text/x-dtd"
    "text/x-java"
    "text/x-python"
    "text/x-sql"
    "text/x-sql"
    "text/x-xsrc"
    "text/xml"
  ]);

in { 
  config.environment.etc."xdg/mimeapps.list" = mkIf (enable && gui.enable) {
    mode = "0444";
    text = toINI {} {
      "Default Applications" =  codeTypes;
      "Added Associations"   =  {};
    };
  }; 
}
