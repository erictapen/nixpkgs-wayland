{ stdenv, fetchFromGitHub
, meson, ninja, pkgconfig
, mesa_noglu
, libdrm
, libxkbcommon
, cairo, wayland, wayland-protocols
, scdoc, buildDocs ? true
}:

let
  metadata = import ./metadata.nix;
in
stdenv.mkDerivation rec {
  name = "sommelier-${version}";
  version = metadata.rev;

  src = /home/cole/code/sommelier_new;
  #src = fetchFromGitHub {
  #  owner = "colemickens";
  #  repo = "sommelier";
  #  rev = metadata.rev;
  #  sha256 = metadata.sha256;
  #};

  nativeBuildInputs = [ pkgconfig meson ninja ]
    ++ stdenv.lib.optional buildDocs [ scdoc ];

  buildInputs = [
    cairo wayland wayland-protocols
    mesa_noglu
    libdrm
    libxkbcommon
  ];

  mesonFlags = [
    "-Dauto_features=enabled"
  ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Wayland proxy thing";
    homepage    = "https://github.com/colemickens/sommelier";
    license     = licenses.mit; # TODO fix
    platforms   = platforms.linux;
    maintainers = with maintainers; [ colemickens ];
  };
}


# weekly 2019/10 - me/them/other
