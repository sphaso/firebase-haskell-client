import Test.Hspec
import Test.QuickCheck
import Control.Exception
import Data.ByteString.Lazy.Char8

import Http
import Types
import UriBuilder
import Auth

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

    describe "UriBuilder with two parameters" $ do
        it "returns a String with the concatenated params" $ do
            (buildParameters [(Callback, "False"), (OrderBy, "date")]) `shouldBe` "Callback=False&OrderBy=date"

    describe "Test configuration is a go" $ do
        it "returns -awesome- when asked for Haskell" $ do
            config <- getConf
            let url = (config !! 1) ++ "haskell.json"
            let authReq = (Auth, Prelude.head config)
            FireResponse body _ _ <- get $ FireRequest url [authReq]
            unpack body `shouldBe` "\"awesome\""
