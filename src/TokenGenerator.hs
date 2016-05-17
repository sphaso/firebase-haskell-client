module TokenGenerator where


import Data.Text (unpack, pack, Text)
import Web.JWT (encodeSigned, secret, JWTClaimsSet, JSON, Algorithm(HS256))

generate :: String -> JWTClaimsSet -> JSON
generate scrt claims = encodeSigned HS256 (secret $ pack scrt) claims