module TokenGenerator where

import Types

import Data.Text (unpack, pack, Text)
import Web.JWT (encodeSigned, secret, JWTClaimsSet, JSON, Algorithm(HS256))

makeClaim :: Int -> [(String, String)] -> FireJWT
makeClaim iat d = FireJWT 0 iat d Nothing Nothing Nothing Nothing

addNbf :: Int -> FireJWT -> FireJWT
addNbf nbf (FireJWT v iat d _ exp admin debug) = FireJWT v iat d (Just nbf) exp admin debug

addExp :: Int -> FireJWT -> FireJWT
addExp exp (FireJWT v iat d nbf _ admin debug) = FireJWT v iat d nbf (Just exp) admin debug

addAdmin :: Bool -> FireJWT -> FireJWT
addAdmin admin (FireJWT v iat d nbf exp _ debug) = FireJWT v iat d nbf exp (Just admin) debug

addDebug :: Bool -> FireJWT -> FireJWT
addDebug debug (FireJWT v iat d nbf exp admin _) = FireJWT v iat d nbf exp admin (Just debug)

generate :: String -> JWTClaimsSet -> JSON
generate scrt claims = encodeSigned HS256 (secret $ pack scrt) claims
