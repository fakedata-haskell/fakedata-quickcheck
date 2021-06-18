{ nixpkgs ? import <nixpkgs> {} }:
let

  inherit (nixpkgs) pkgs;
  inherit (pkgs) haskellPackages;

  fakedata_quickcheck = (import ./release.nix {}).lts18.env;
in
pkgs.stdenv.mkDerivation {
  name = "shell";
  buildInputs = fakedata_quickcheck.nativeBuildInputs ++ [ pkgs.stack ];
}
