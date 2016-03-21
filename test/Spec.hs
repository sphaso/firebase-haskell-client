import Test.Hspec
import Test.QuickCheck
import Control.Exception
import Http
import Types

-- TODO this is not working yet. Also in the repl, if put the following:
-- response = get $ FireRequest "http://httpbin.org/xml" []
-- response has the type of IO FireResponse, and I can't figure out how to access its body or status.

main :: IO ()
main = hspec $ do
    describe "Http.get" $ do
        it "returns the contens of httpbin.org/xml" $ do
            (FireResponse _ status _) <- get $ FireRequest "http://httpbin.org/xml" []
            status `shouldBe` 200
