{ pkgs ? import (
  builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/de9fd44809f6629b64ee5d29cb3ac8c9e49904d3.tar.gz"
  ) { }
}:

with pkgs;

let
  pmdmini = callPackage ./dependencies/pmdmini.nix { };
in
mkShell {
  buildInputs = [
    dosbox
    pmdmini
  ];
}
