{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE OverloadedStrings #-}

module Test.FakeQuickCheckSpec
  ( spec
  )
where

import qualified Faker.Company as CM
import Faker
import Test.QuickCheck.Gen.Faker
import Data.Text (Text)
import           Text.Regex.TDFA         hiding (empty)
import qualified Data.Text as T
import qualified Faker.Internet as F
import           Test.Hspec
import qualified Test.QuickCheck as Q
import qualified Test.QuickCheck.Gen as QG
import Data.Char(isAlphaNum)
import Data.List (nub)

isDomain :: Text -> Bool
isDomain = (=~ ddd) . T.unpack
  where
    ddd :: Text
    ddd =  "^[A-Za-z_]+\\.[a-z]{1,4}$"

spec :: Spec
spec = do
  describe "fakedata quickcheck" $ do
    it "forall domain fullfils is a domain name regex" $ Q.property (Q.forAll (fakeQuickcheck domain) isDomain)
    it "has different sample values" $ do
      values <- QG.sample' (fakeQuickcheck CM.name)
      (isUnique values) `shouldBe` True

domain :: Fake Text
domain = do
  suffix <- F.domainSuffix
  companyName <- CM.name
  pure $ fixupName companyName <> "." <> suffix

fixupName :: Text -> Text
fixupName = T.filter (\c -> isAlphaNum c || c == '_') . T.replace " " "_"

-- | Check that at least a single value is different
isUnique :: [Text] -> Bool
isUnique xs = length (nub xs) > 1
