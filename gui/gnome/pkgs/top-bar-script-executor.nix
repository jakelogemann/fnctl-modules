{ stdenv, fetchFromGitHub }:
# TODO: In the future, this should probably migrate to
#       gitlab.com/fnctl/nix/pkgs/overlay or perhaps nixpkgs!
stdenv.mkDerivation rec {
  name = "gnome-shell-extension-top-bar-script-executor-${version}";
  version = "714f539d313b8501c594e8c97d77e74a29d287f5";

  src = fetchFromGitHub {
    owner = "sambazley";
    repo = "Top-bar-script-executor";
    rev = "${version}";
    sha256 = "039id41yv1c2yrslvg46z1c27xkqj1bbgzh6h88ban49kpc5c6hm";
  };

  patches = [ ./top-bar-script-executor-nixos.patch ];

  # This package has a Makefile, but it's used for building a zip for
  # publication to extensions.gnome.org. Disable the build phase so
  # installing doesn't build an unnecessary release.
  dontBuild = true;

  uuid = "scriptexec@samb1999.hotmail.co.uk";

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp -r * $out/share/gnome-shell/extensions/${uuid}
  '';

  meta = with stdenv.lib; {
    description = "Adds buttons to the top bar that execute scripts";
    license = license.gpl2; # TODO: No license listed but null doesn't work.
    maintainers = with maintainers; [ /* christinegraham */ jakelogemann ];
    homepage = "https://github.com/sambazley/Top-bar-script-executor";
  };
}