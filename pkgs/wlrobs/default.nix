{ stdenv, fetchFromGitHub
, meson, ninja, pkgconfig
, libdrm, wayland, wayland-protocols
, ffmpeg_4, libpulseaudio
, fetchpatch
}:

let
  metadata = import ./metadata.nix;
in
stdenv.mkDerivation rec {
  name = "wlstream-${version}";
  version = metadata.rev;

  src = fetchgit {
    url = "https://bitbucket.org/Scoopta/wlrobs";
    sha256 = metadata.sha256;
  };

  enableParallelBuilding = true;
  nativeBuildInputs = [ meson ninja pkgconfig ];
  buildInputs = [
    wayland wayland-protocols
    libobs
  ];
  mesonFlags = [
    "-Dauto_features=enabled"
  ];

  meta = with stdenv.lib; {
    description = "wlroots-compatible screen capture application";
    homepage    = "https://github.com/atomnuker/wlstream";
    license     = licenses.gpl2;
    platforms   = platforms.linux;
    maintainers = with maintainers; [ colemickens ];
  };
}
