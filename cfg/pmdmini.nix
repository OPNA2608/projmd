{ stdenv, lib, fetchFromGitHub, fetchpatch
, cmake, pkg-config
, SDL2
}:

stdenv.mkDerivation rec {
  pname = "pmdmini";
  version = "unstable-2021-05-02";

  src = fetchFromGitHub {
    owner = "gzaffin";
    repo = "pmdmini";
    rev = "aa29450a0dbb2be9240d5ec0518b73e4f05e7a3a";
    sha256 = "0xapri5rrk3lilyszxigfm2lcy4ikfsd25xym7qxz7r0psq367sk";
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
