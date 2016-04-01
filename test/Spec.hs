import Test.Hspec
import Test.QuickCheck
import Control.Exception
import Data.ByteString.Lazy.Char8

import Http
import Types
import UriBuilder
import Auth
import FireLogic

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

    describe "Test configuration is a go" $ do
        it "returns -awesome- when asked for Haskell" $ do
            config <- getConf
            let url = (config !! 1) ++ "haskell.json"
            let authReq = (Auth, Prelude.head config)
            FireResponse body _ _ <- get $ FireRequest url [authReq]
            unpack body `shouldBe` "\"awesome\""

    -- ### UNIT TESTS ###

    -- # FireLogic module #

    -- onlyShallow
    describe "onlyShallow with only Shallow param" $ do
        it "throws no error" $ do
            onlyShallow [(Shallow, "3")] `shouldBe` True
    describe "onlyShallow with Shallow and OrderBy param" $ do
        it "throws an error" $ do
            evaluate (onlyShallow [(Shallow, "3"),(OrderBy, "date")]) `shouldThrow` anyException   

     -- onlyGet
    describe "onlyGet with Callback and Format param" $ do
        it "throws no error" $ do
            onlyGet [(Callback, "true"), (Format, "unknown")] `shouldBe` True
    describe "onlyGet with Shallow and OrderBy param" $ do
        it "throws an error" $ do
            evaluate (onlyShallow [(Shallow, "3"),(OrderBy, "date")]) `shouldThrow` anyException   


    -- # UriBuilder module #

    -- buildParameters
    describe "UriBuilder with two parameters" $ do
        it "returns a String with the concatenated params" $ do
            (buildParameters [(Callback, "False"), (OrderBy, "date")]) `shouldBe` "Callback=False&OrderBy=date"