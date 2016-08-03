module TokenGenerator where

import Types

import Data.Text (unpack, pack, Text)
import Crypto.JWT (ClaimsSet)
--import Web.JWT (def, StringOrURI, stringOrURI, encodeSigned, secret, ClaimsMap, JWTClaimsSet(..), JSON, Algorithm(HS256))

makeClaim :: Int -> [(String, String)] -> FireJWT
makeClaim iat d = FireJWT 0 iat d Nothing Nothing Nothing Nothing

makeWholeClaim :: Int -> [(String, String)] -> Maybe Int -> Maybe Int -> Maybe Bool -> Maybe Bool -> FireJWT
makeWholeClaim iat d nbf exp admin debug = FireJWT 0 iat d nbf exp admin debug

--generate :: String -> ClaimsSet -> JSON
--generate scrt claims = encodeSigned HS256 (secret $ pack scrt) claims

--TODO: JWTClaimsSet and ClaimsMap constructors not in scope (solution needed or change approach)
claimsFromFireJWT :: FireJWT -> ClaimsSet
claimsFromFireJWT (FireJWT v iat d nbf exp admin debug)
       = emptyClaimsSet
            & claimIat .~ iat
            & claimNbf .~ nbf
            & addClaim "v" v
            & addClaim "d" d
            & addClaim "admin" (Bool admin)
            & addClaim "debug" (Bool debug)
