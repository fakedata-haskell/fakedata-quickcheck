{ compiler ? "ghc8104" }:

let
  bootstrap = import <nixpkgs> {};

  nixpkgs = builtins.fromJSON (builtins.readFile ./nixpkgs.json);

  src = bootstrap.fetchFromGitHub {
    owner = "NixOS";
    repo  = "nixpkgs";
    inherit (nixpkgs) rev sha256;
  };

  config = {
    packageOverrides = pkgs: rec {
      haskell = pkgs.haskell // {
        packages = pkgs.haskell.packages // {
          "${compiler}" = pkgs.haskell.packages."${compiler}".override {
            overrides = haskellPackagesNew: haskellPackagesOld: rec {
              fakedata-quickcheck = haskellPackagesNew.callPackage ./fakedata-quickcheck.nix {};
            };
          };
        };
      };
    };
  };

  pkgs = import src { inherit config; };

in
  {
    lts18 = pkgs.haskell.packages.ghc8104.fakedata-quickcheck;
    lts16 = pkgs.haskell.packages.ghc884.fakedata-quickcheck;
    lts14 = pkgs.haskell.packages.ghc865Binary.fakedata-quickcheck;
  }
