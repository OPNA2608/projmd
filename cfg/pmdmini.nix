{
  stdenv,
  lib,
  fetchFromGitHub,
  fetchpatch,
  cmake,
  pkg-config,
  SDL2,
}:

stdenv.mkDerivation rec {
  pname = "pmdmini";
  version = "2.0-unstable-2024-09-08";

  src = fetchFromGitHub {
    owner = "gzaffin";
    repo = "pmdmini";
    rev = "88406c57c124ed7034617e78f3700416df552d6f";
    hash = "sha256-VTJH9RrxJDrTs1HT/33a8jQXjwiNBFmSgpV4qJm5oAQ=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [ SDL2 ];

  makeFlags = [
    "pmdplay"
  ];

  # Debugging

  # cmakeFlags = [
  #   "-DCMAKE_BUILD_TYPE=Debug"
  # ];
  # dontStrip = true;

  meta = {
    description = "Professional Music Driver (PMD) format player using Simple DirectMedia Layer (SDL) version 2.x";
    homepage = "https://github.com/gzaffin/pmdmini";
    license = lib.licenses.gpl2Only;
    mainProgram = "pmdplay";
    maintainers = [ ]; # lib.maintainers.OPNA, but this isn't Nixpkgs lol
    platforms = lib.platforms.unix;
  };
}
