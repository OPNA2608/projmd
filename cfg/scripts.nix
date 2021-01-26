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
    cd $src
    for script in *; do
      install -Dm755 $script $out/bin/$script
    done
    substituteInPlace $out/bin/pmd \
      --replace 'DOSBOX=dosbox' 'DOSBOX=${dosbox}/bin/dosbox'
  '';
}
