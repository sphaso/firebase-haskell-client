import Test.Hspec
import Test.QuickCheck
import Control.Exception
import Http
import Types

main :: IO ()
main = hspec $ do

    -- ### INTEGRATION TESTS ###
    describe "Http.get" $ do
        it "returns the contens of httpbin.org/xml" $ do
            (FireResponse _ status _) <- get $ FireRequest "http://httpbin.org/xml" []
            status `shouldBe` 200

    describe "Http.get with empty parameters" $ do
        it "throws an error" $ do
            (get $ FireRequest "http://httpbin.org.xml" [(Format, "")]) `shouldThrow` anyException
