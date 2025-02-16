{ stdenv, lib, fetchFromGitHub, fetchpatch
, cmake, pkg-config
, SDL2
}:

stdenv.mkDerivation rec {
  pname = "pmdmini";
  version = "0-unstable-2023-05-26";

  src = fetchFromGitHub {
    owner = "gzaffin";
    repo = "pmdmini";
    rev = "b878a46ef18b1a8061405b3ac57f5f779f198042";
    hash = "sha256-CtyobNCNWWGxXeCm9m64Mr9yHcNe4Of7vA9IhcEnVU8=";
  };

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [ SDL2 ];

  makeFlags = [
    "pmdplay"
  ];

  # Debugging

  # cmakeFlags = [
  #   "-DCMAKE_BUILD_TYPE=Debug"
  # ];
  # dontStrip = true;
}
