{ pkgs ? import ./nix/pin.nix {},
  ... }:

let
  hpkgs = pkgs.haskellPackages;
  ignore = import ./nix/gitignoreSource.nix { inherit (pkgs) lib; };
  # https://github.com/NixOS/nixpkgs/blob/dbacb52ad8/pkgs/development/haskell-modules/make-package-set.nix#L216
  src = ignore.gitignoreSource ./.;
  cabal2nix =
    hpkgs.callCabal2nix "fakedata-quickcheck" src {

      fakedata = pkgs.haskell.lib.unmarkBroken
        (pkgs.haskell.lib.dontCheck hpkgs.fakedata);
    };
in
# https://github.com/NixOS/nixpkgs/blob/dbacb52ad8/pkgs/development/haskell-modules/generic-builder.nix#L13

pkgs.haskell.lib.overrideCabal cabal2nix (drv: {
  inherit src;
  isExecutable = true;
})
