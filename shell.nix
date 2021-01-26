{ pkgs ? import (
  builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/de9fd44809f6629b64ee5d29cb3ac8c9e49904d3.tar.gz"
  ) { }
, projmdDir ? null
}:

with pkgs;

let
  pmdmini = enableDebugging (callPackage ./cfg/pmdmini.nix { });
  projmd_scripts = callPackage ./cfg/scripts.nix {
    pmdmini = pmdmini;
  };
in
mkShell {
  buildInputs = [
    dosbox
    pmdmini
    projmd_scripts
  ];

  shellHook = ''
    export PROJMD_BASE=${if projmdDir != null then projmdDir else "$(realpath .)"}
    echo "=== Set ProjMD base directory PROJMD_BASE ==="
    echo "-> $PROJMD_BASE"
    echo ""
    echo "If this is incorrect, either do"
    echo "  cd /path/to/projmd"
    echo "before entering the nix-shell or pass"
    echo "  --argstr projmdDir /path/to/projmd"
    echo "to your nix-shell invocation!"

    export SDL_VIDEODRIVER=dummy
    echo "=== Set SDL dummy driver ==="
  '';
}
