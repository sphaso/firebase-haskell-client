import Test.Hspec
import Test.QuickCheck
import Control.Exception
import Data.ByteString.Lazy.Char8

import qualified UnitTests as UT
import qualified IntegrationTests as IT

main :: IO ()
main = hspec spec

spec :: Spec
spec = do
        describe "Integration" IT.spec
        describe "Unit" UT.spec
