{ stdenv, fetchFromGitHub }:
# TODO: In the future, this should probably migrate to
#       gitlab.com/fnctl/nix/pkgs/overlay or perhaps nixpkgs!
stdenv.mkDerivation rec {
  name = "gnome-shell-extension-shelltile-${version}";
  version = "2.0.0";

  src = fetchFromGitHub {
    owner = "emasab";
    repo = "shelltile";
    rev = "${version}";
    sha256 = "1mvqfklnjr995ygx4dkqpbbciq9cc5q8mxmxbc34v4la2gnbndk1";
  };

  uuid = "ShellTile@emasab.it";

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp -r * $out/share/gnome-shell/extensions/${uuid}
  '';

  meta = with stdenv.lib; {
    description = "A tiling window extension for GNOME shell.";
    license = licenses.gpl2;
    maintainers = with maintainers; [ /* christinegraham */ jakelogemann ];
    homepage = "https://github.com/emasab/shelltile/tree/quicktiling";
  };
}