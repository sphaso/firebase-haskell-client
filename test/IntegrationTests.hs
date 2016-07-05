module IntegrationTests where

import Test.Hspec
import Test.QuickCheck
import Control.Exception
import Data.ByteString.Lazy.Char8

import Http
import Types
import UriBuilder
import Auth
import FireLogic
--import JWT -- not yet existing, will provide the generateJWT function.

spec :: Spec
spec = do
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

-- # JWT Module
--        it "return -awesome- when asked for Haskell" $ do
--            config <- getConf
--            let url = (config !! 1) ++ "haskell.json"
--            let secret = (Auth, Prelude.head config)
--            FireResponse body _ _ <- get $ FireRequest url [generateJWT secret ] -- the payload itself (body) will possibly also have to go into the generateJWT function
--            unpack body `shouldBe` "\"awesome\""
