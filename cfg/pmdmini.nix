{ stdenv, lib, fetchFromGitHub, fetchpatch
, cmake, pkg-config
, SDL2
}:

let
  shaNormal = "1pf8bap33jwj97fdb321b0lc1hc0jbay4kv48yvfyv1z7gr3770i";
  shaDarwin = "17ckp9nmq56izri9lbh04yi1l2p82ybkn12hljwkwy73jx4870g6";
in
stdenv.mkDerivation rec {
  pname = "pmdmini";
  version = "2.0";

  src = fetchFromGitHub {
    owner = "gzaffin";
    repo = "pmdmini";
    rev = "v${version}";
    sha256 = if stdenv.hostPlatform.isDarwin then shaDarwin else shaNormal;
  };

  patches = [
    # Both fix: redefinition of struct 'statx_timestamp'
    (fetchpatch {
      url = "https://github.com/gzaffin/pmdmini/commit/c892859ae325210c493cac9bb59294af6a2e33eb.patch";
      sha256 = "00kvq014ma2066wc2rrjv4cfdbi07n4rg5j1xfsrmbyw12r3gxs4";
    })
    (fetchpatch {
      url = "https://github.com/gzaffin/pmdmini/commit/9f05a3ddb75c12af2184606058a04d94a384fd2d.patch";
      sha256 = "05viia9wmp9dryxdbsk6h22ww2cv54v5gkqxlyzrm2jaxkqkc55a";
    })
    # Fix malloc.h missing on Darwin
    (fetchpatch {
      url = "https://github.com/gzaffin/pmdmini/commit/b4e8022bcc69e331ce5593af89fdbccae1bf2c3e.patch";
      sha256 = "1gy4n2lkf32yfhbakihidm7q90c5zm2sq9annvnc88ndbmi56grc";
    })
    # Install target
    (fetchpatch {
      url = "https://github.com/gzaffin/pmdmini/commit/20be1e8b3f49f786b520613723bc6b4775c14361.patch";
      sha256 = "1gfi7sg1bmal65qrl93bm38vjwp0z4hh2kc9spvb92myl2dp96g5";
    })
    # SDL2 linking
    (fetchpatch {
      url = "https://github.com/gzaffin/pmdmini/commit/6b59fdf6faf1b0fac37b1852e1a4c010f92f3b0d.patch";
      sha256 = "1fk4kcrh8xhm2gyb76az9ab9lg6prpngjgxl99823pl16inpsi63";
    })
    (fetchpatch {
      url = "https://github.com/gzaffin/pmdmini/commit/92bbf2aa8d82bf20db29165d12bb7fea996de39e.patch";
      sha256 = "0ji1k3i6ghap1kwfca7sl1wvkv449gdji4jc5lyaiwnv08kiqlxb";
    })
  ];

  nativeBuildInputs = [ cmake pkg-config ];

  buildInputs = [ SDL2 ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Debug"
  ];
  dontStrip = true;
}
