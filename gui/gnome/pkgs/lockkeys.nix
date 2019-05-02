{ stdenv, fetchFromGitHub }:
# TODO: In the future, this should probably migrate to
#       gitlab.com/fnctl/nix/pkgs/overlay or perhaps nixpkgs!
stdenv.mkDerivation rec {
  name = "gnome-shell-extension-lockkeys-${version}";
  version = "0a26330b209c88defe01f48ab6e51d2c0e1d1d71";

  src = fetchFromGitHub {
    owner = "kazysmaster";
    repo = "gnome-shell-extension-lockkeys";
    rev = "${version}";
    sha256 = "1gl7grs8lwgzhwdxyihbn32g3vg7fljlz1l36rkc471lmnyn6k4b";
  };

  uuid = "lockkeys@vaina.lt";

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp -r ./lockkeys@vaina.lt/* $out/share/gnome-shell/extensions/${uuid}
  '';

  meta = with stdenv.lib; {
    description = "Numlock & Capslock status on the panel";
    license = licenses.gpl2;
    maintainers = with maintainers; [ /* christinegraham */ jakelogemann ];
    homepage = "https://github.com/kazysmaster/gnome-shell-extension-lockkeys";
  };
}
