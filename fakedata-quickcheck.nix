{ mkDerivation, base, fakedata, hpack, hspec, hspec-core, lib
, QuickCheck, random, regex-tdfa, text
}:
mkDerivation {
  pname = "fakedata-quickcheck";
  version = "0.1.0";
  src = ./.;
  libraryHaskellDepends = [ base fakedata QuickCheck random ];
  libraryToolDepends = [ hpack ];
  testHaskellDepends = [
    base fakedata hspec hspec-core QuickCheck random regex-tdfa text
  ];
  prePatch = "hpack";
  homepage = "https://github.com/fakedata-haskell/fakedata-quickcheck#readme";
  description = "Fake a -> Gen a";
  license = lib.licenses.mit;
}
