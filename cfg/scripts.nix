{ stdenv
, lib
, dosbox
, nkf
, pmdmini
, mpv-unwrapped
, fswatch
, killall
}:

let
  mpv = if (lib.strings.versionAtLeast mpv-unwrapped.version "0.35.0") then mpv-unwrapped.override {
    # https://github.com/mpv-player/mpv/issues/10859 breaks playback on systems that don't actually use PW
    pipewireSupport = false;
  } else mpv-unwrapped;
in
stdenv.mkDerivation rec {
  name = "projmd-scripts";

  src = ./scripts;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  propagatedBuildInputs = [
    dosbox
    nkf
    pmdmini
    mpv
    fswatch
    killall
  ];

  installPhase = ''
    cd $src
    for script in *; do
      install -Dm755 $script $out/bin/$script
    done
    substituteInPlace $out/bin/pmd \
      --replace 'DOSBOX=dosbox' 'DOSBOX=${dosbox}/bin/dosbox' \
      --replace 'NKF=nkf' 'NKF=${nkf}/bin/nkf' \
      --replace 'PMDPLAY=pmdplay' 'PMDPLAY=${pmdmini}/bin/pmdplay' \
      --replace 'MPV=mpv' 'MPV=${mpv}/bin/mpv' \
      --replace 'FSWATCH=fswatch' 'FSWATCH=${fswatch}/bin/fswatch' \
      --replace 'KILLALL=killall' 'KILLALL=${killall}/bin/killall'
  '';
}
