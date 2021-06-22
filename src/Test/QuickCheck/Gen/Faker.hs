module Test.QuickCheck.Gen.Faker
  ( fakeQuickcheck'
  , fakeQuickcheck
  )
where

import           Faker
import           System.IO.Unsafe (unsafePerformIO)
import           System.Random    (mkStdGen)
import qualified Test.QuickCheck  as Q

fakeQuickcheck :: Fake a -> Q.Gen a
fakeQuickcheck = fakeQuickcheck' defaultFakerSettings

-- | Select a value 'Fake' program in 'Gen'.
--
-- Example property to check that names aren't empty:
--
-- @
-- λ> import Faker.Name (name)
-- λ> import Test.QuickCheck.Gen.Faker
-- λ> import qualified Test.QuickCheck as Q
-- λ> import qualified Data.Text as T
-- λ> Q.quickCheck (Q.forAll (fakeQuickcheck name) (not . T.null))
-- +++ OK, passed 100 tests.
--
-- @

fakeQuickcheck' :: FakerSettings -> Fake a -> Q.Gen a
fakeQuickcheck' fakerSettings f = do
    randomGen <- mkStdGen <$> Q.choose (minBound, maxBound)
    pure $!
        unsafePerformIO $
        -- (parsonsmatt): OK so `unsafePerformIO` is bad, unless you know exactly
        -- what you're doing, so do I know exactly what I am doing? Perhaps I can
        -- convince you.
        --
        -- The Faker library doesn't keep the data as Haskell values, but stores it
        -- in `data-files`. The code that generates this fake data loads the values
        -- from the `data-files` for the library. That's what happens in IO. It is
        -- possible that the data-file is missing, and an exception will be thrown.
        -- However, no mutating actions are performed. I believe this is a safe use
        -- of 'unsafePerformIO'.
        --
        -- The alternative would be to lift it into `GenT IO a`, which is
        -- undesirable, as it would harm composition with basically any other
        -- generator.
        Faker.generateWithSettings
            (Faker.setRandomGen
              randomGen
              fakerSettings
            )
            f
