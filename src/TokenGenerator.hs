module TokenGenerator where

import Types

import Data.Text (unpack, pack, Text)
import Web.JWT (def, StringOrURI, stringOrURI, encodeSigned, secret, ClaimsMap, JWTClaimsSet(..), JSON, Algorithm(HS256))

makeClaim :: Int -> [(String, String)] -> FireJWT
makeClaim iat d = FireJWT 0 iat d Nothing Nothing Nothing Nothing

makeWholeClaim :: Int -> [(String, String)] -> Maybe Int -> Maybe Int -> Maybe Bool -> Maybe Bool -> FireJWT
makeWholeClaim iat d nbf exp admin debug = FireJWT 0 iat d nbf exp admin debug

generate :: String -> JWTClaimsSet -> JSON
generate scrt claims = encodeSigned HS256 (secret $ pack scrt) claims

--TODO: JWTClaimsSet and ClaimsMap constructors not in scope (solution needed or change approach)
claimsFromFireJWT :: FireJWT -> JWTClaimsSet
claimsFromFireJWT (FireJWT v iat d nbf exp admin debug)
    = def { iss = stringOrURI (pack "Foo") }
        -- where d = insert "admin" admin $ insert "debug" debug . empty
