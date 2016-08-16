{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE LambdaCase #-}

module TokenGenerator where

import Types

import Data.Bool
import Data.Text (unpack, pack, Text)
import Data.Aeson hiding ((.=))
import Data.Time (UTCTime, NominalDiffTime)
import Data.Time.Clock.POSIX (posixSecondsToUTCTime)
import Control.Lens
import Data.Time

import Crypto.JWT
--import Web.JWT (def, StringOrURI, stringOrURI, encodeSigned, secret, ClaimsMap, JWTClaimsSet(..), JSON, Algorithm(HS256))

makeClaim :: Int -> [(String, String)] -> FireJWT
makeClaim iat d = FireJWT 0 iat d Nothing Nothing Nothing Nothing

makeWholeClaim :: Int -> [(String, String)] -> Maybe Int -> Maybe Int -> Maybe Bool -> Maybe Bool -> FireJWT
makeWholeClaim iat d nbf exp admin debug = FireJWT 0 iat d nbf exp admin debug

--generate :: String -> ClaimsSet -> JSON
--generate scrt claims = encodeSigned HS256 (secret $ pack scrt) claims

maybeToBool :: Maybe Bool -> Bool
maybeToBool (Just a) = a
maybeToBool Nothing = False

maybeToInt :: Maybe Int -> Int
maybeToInt (Just a) = a
maybeToInt Nothing = 0

--TODO: JWTClaimsSet and ClaimsMap constructors not in scope (solution needed or change approach)
--claimsFromFireJWT (FireJWT v iat d nbf exp admin debug)
--       = emptyClaimsSet
--            & claimIat .~ (realToFrac ())
--            & claimNbf .~ (realToFrac $ maybeToInt nbf)
--            & addClaim "v" (toJSON v)
--            & addClaim "d" (toJSON d)
--            & addClaim "admin" (Bool (maybeToBool admin))
--            & addClaim "debug" (Bool (maybeToBool debug))

--helper function from the hs-jose tests
intDate :: String -> Maybe NumericDate
intDate = fmap NumericDate . parseTimeM True defaultTimeLocale "%F %T"

claimsFromScratch :: ClaimsSet
claimsFromScratch
		= emptyClaimsSet
		    & claimIss .~ Just (fromString "test@test.com")
		    & claimSub .~ Just (fromString "test@test.com")
		    & claimAud .~ Just (fromString "some audience")
		    & claimIat .~ intDate "2011-03-22 18:43:00"
  			& claimExp .~ intDate "2011-03-22 19:43:00"
  			& addClaim "uid" (Just (fromString "user1"))
  			& addClaim "http://example.com/is_root" (Bool True)
