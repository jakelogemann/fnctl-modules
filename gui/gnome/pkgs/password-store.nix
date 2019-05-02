{ stdenv, fetchFromGitHub }:
# TODO: In the future, this should probably migrate to
#       gitlab.com/fnctl/nix/pkgs/overlay or perhaps nixpkgs!
stdenv.mkDerivation rec {
  name = "gnome-shell-extension-password-store-${version}";
  version = "0b38fd3ae884278c263f070e27cfb0ab52fc7458";

  src = fetchFromGitHub {
    owner = "mcat95";
    repo = "pass-extension";
    rev = "${version}";
    sha256 = "1q03w4g96iy2x4hki7xqlrvlxk7x621659vx5zrs9jfqkbwlfz46";
  };

  uuid = "passwordstore@mcat95.gmail.com";

  installPhase = ''
    mkdir -p $out/share/gnome-shell/extensions/${uuid}
    cp -r * $out/share/gnome-shell/extensions/${uuid}
  '';

  meta = with stdenv.lib; {
    description = "Access your passwords from pass (passwordstore.org) from the gnome-shell";
    license = licenses.gpl2;
    maintainers = with maintainers; [ /* christinegraham */ jakelogemann ];
    homepage = "https://github.com/mcat95/pass-extension";
  };
}
