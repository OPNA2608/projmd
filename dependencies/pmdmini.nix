{ stdenv, lib, fetchFromGitHub
, cmake, pkg-config
, SDL2
}:

stdenv.mkDerivation rec {
  pname = "pmdmini";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "gzaffin";
    repo = "pmdmini";
    rev = "v${version}";
    sha256 = "1pf8bap33jwj97fdb321b0lc1hc0jbay4kv48yvfyv1z7gr3770i";
  };

  postPatch = ''
    # redefinition of 'struct statx_timestamp'
    substituteInPlace src/fmgen/headers.h \
      --replace '#include <linux/stat.h>' '//#include <linux/stat.h>'

    # no install step
    substituteInPlace CMakeLists.txt \
      --replace 'EXCLUDE_FROM_ALL' "" \
      --replace \
        'target_compile_options(pmdplay PUBLIC $''\{SDL2_FLAGS} $''\{SDL2_FLAGS_OTHERS})' \
        'target_compile_options(pmdplay PUBLIC $''\{SDL2_FLAGS} $''\{SDL2_FLAGS_OTHERS})''\ninstall(TARGETS pmdplay DESTINATION $''\{CMAKE_INSTALL_BINDIR})'
  '';

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [ SDL2 ];
}
