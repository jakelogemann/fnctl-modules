{ config, pkgs, lib, ... }: with lib;
with (import ../gnome/_helpers.nix { inherit pkgs lib; });

let inherit (config.fnctl2) enable gui; in {
  config = mkIf (enable && gui.enable) {
    environment.systemPackages = [(pkgs.buildEnv {
      name = "nvim-appitems";
      paths = with pkgs; [
        (makeDesktopItem {
          name        = "NVIM";
          desktopName = "NVIM";
          comment     = "NeoVim in Alacritty";
          exec        = "alacritty --title NVIM --class NVIM --command nvim -p5 %F";
          icon        = ./icons/gnvim.svg;
          type        = "Application";
          categories  = concatStringsSep ";" [
            "Utility"
            "TextEditor"
            "Development"
            "IDE"
          ];
          mimeType = concatStringsSep ";" [
            "text/plain" 
            "inode/directory"
            "application/x-perl"
            "text/html"
            "text/mathml"
            "text/x-c++hdr"
            "text/x-c++src"
            "text/x-chdr"
            "text/x-csrc"
            "text/x-dtd"
            "text/x-java"
            "text/x-patch"
            "text/x-python"
            "text/x-sql"
            "text/x-xsrc"
            "text/xml"
          ];
        })
      ];
    })];
  };
}
