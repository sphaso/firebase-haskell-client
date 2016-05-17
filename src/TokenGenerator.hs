module TokenGenerator where

import Types (FireJWT)

import Data.Text (unpack, pack, Text)
import Web.JWT (encodeSigned, secret, JWTClaimsSet, JSON, Algorithm(HS256))

makeClaim :: Int -> [(String, String)] -> FireJWT
makeClaim iat d = FireJWT 0 iat d

generate :: String -> JWTClaimsSet -> JSON
generate scrt claims = encodeSigned HS256 (secret $ pack scrt) claims
