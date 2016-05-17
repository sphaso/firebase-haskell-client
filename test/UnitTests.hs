module UnitTests where

import Test.Hspec
import Test.QuickCheck
import Control.Exception
import Data.ByteString.Lazy.Char8

import Http
import Types
import UriBuilder
import Auth
import FireLogic

spec :: Spec
spec = do
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


  -- # DRAFTS for test cases based on Firebase Docs

  -- test for a request without token version (server or client side validation)?
  -- test for a request without iat (issued at) ''
  -- test for a request without data
  -- test for a request with admin (and test wether we can really mess something up in an amin fashion)
  -- somehow test optional claims: nbf, exp, admin, debug