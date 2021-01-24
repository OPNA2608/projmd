{ stdenv, lib
, dosbox, pmdmini
}:

stdenv.mkDerivation rec {
  name = "projmd-scripts";

  src = ./scripts;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  buildInputs = [ dosbox pmdmini ];

  installPhase = ''
    pushd $src
    for script in *; do
      install -Dm755 $script $out/bin/$script
      substituteInPlace $out/bin/$script \
        --replace 'DOSBOX=dosbox' 'DOSBOX=${dosbox}/bin/dosbox'
    done
    popd
  '';
}
