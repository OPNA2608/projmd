{ stdenv, lib
, dosbox, nkf, pmdmini, fswatch
}:

stdenv.mkDerivation rec {
  name = "projmd-scripts";

  src = ./scripts;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  buildInputs = [ dosbox nkf pmdmini fswatch ];

  installPhase = ''
    cd $src
    for script in *; do
      install -Dm755 $script $out/bin/$script
    done
    substituteInPlace $out/bin/pmd \
      --replace 'DOSBOX=dosbox' 'DOSBOX=${dosbox}/bin/dosbox' \
      --replace 'NKF=nkf' 'NKF=${nkf}/bin/nkf' \
      --replace 'PMDPLAY=pmdplay' 'PMDPLAY=${pmdmini}/bin/pmdplay' \
      --replace 'FSWATCH=fswatch' 'FSWATCH=${fswatch}/bin/fswatch'
  '';
}
