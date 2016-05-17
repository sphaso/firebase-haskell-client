module TokenGenerator where

import Types

import Data.Text (unpack, pack, Text)
import Web.JWT (encodeSigned, secret, JWTClaimsSet, JSON, Algorithm(HS256))

makeClaim :: Int -> [(String, String)] -> FireJWT
makeClaim iat d = FireJWT 0 iat d Nothing Nothing Nothing Nothing

makeWholeClaim :: Int -> [(String, String)] -> Maybe Int -> Maybe Int -> Maybe Bool -> Maybe Bool -> FireJWT
makeWholeClaim iat d nbf exp admin debug = FireJWT 0 iat d nbf exp admin debug

generate :: String -> JWTClaimsSet -> JSON
generate scrt claims = encodeSigned HS256 (secret $ pack scrt) claims

claimsFromFireJWT :: FireJWT -> JWTClaimsSet
claimsFromFireJWT FireJWT (v, iat, d, nbf, exp, admin, debug)
    = JWTClaimsSet (Nothing, Nothing, Nothing, exp, nbf, iat, Nothing, ClaimsMap d) --TODO: checkout ClaimsMap constructor and append admin/debug there as well
