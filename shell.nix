{ pkgs ? import (
  builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/a9efc15c162d747295cb97964512cbc7fd2593e7.tar.gz"
  ) { }
, projmdDir ? null
}:

with pkgs;

let
  pmdmini = /* enableDebugging broken, see https://github.com/NixOS/nixpkgs/issues/136756 */ (callPackage ./cfg/pmdmini.nix { });
  projmd_scripts = callPackage ./cfg/scripts.nix {
    pmdmini = pmdmini;
  };
in
mkShell {
  buildInputs = [
    projmd_scripts
  ];

  shellHook = ''
    cat ${./banner.txt}
    echo ""

    export PROJMD_BASE=${if projmdDir != null then projmdDir else "$(realpath .)"}
    echo "=== Set ProjMD base directory ==="
    echo "-> PROJMD_BASE='$PROJMD_BASE'"
    echo ""
    echo "! If this is incorrect, either do"
    echo "!   cd /path/to/projmd"
    echo "! before entering the nix-shell or pass"
    echo "!   --argstr projmdDir /path/to/projmd"
    echo "! to your nix-shell invocation!"
    echo ""

    export SDL_VIDEODRIVER=dummy
    echo "=== Set SDL dummy driver ==="
    echo "-> SDL_VIDEODRIVER='$SDL_VIDEODRIVER'"
  '';
}
