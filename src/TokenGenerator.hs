module TokenGenerator where

import Data.Text (pack, Text)
import Web.JWT (encodeSigned, secret, JWTClaimsSet, JSON, Algorithm(HS256))

generate :: String -> JWTClaimsSet -> JSON
generate secret claims = encodeSigned HS256 (secret $ pack secret) claims
