{ stdenv }:

stdenv.mkDerivation rec {
  name = "custom-icons-${version}";
  version = "1.0.0";

  src = ./.;

  installPhase = ''
    mkdir -p $out/share/icons/hicolor/scalable/status
    cp ./custom-icons/*.svg $out/share/icons/hicolor/scalable/status/
  '';

  meta = with stdenv.lib; {
    description = "Installs custom icons to the Nix store";
    license = licenses.gpl2;
    maintainers = with maintainers; [ /* christinegraham */ jakelogemann ];
    homepage = "https://gitlab.com/fnctl/nix";
  };
}