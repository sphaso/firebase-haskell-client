module Types where

import Data.ByteString.Lazy
import Network.HTTP.Types.Header

type RequestParameter = (QueryParameter, String)

data QueryParameter = Auth | Shallow | Callback | Format | OrderBy | LimitToFirst | LimitToLast | StartAt | EndAt | EqualTo | Print | Download deriving (Eq, Show)

data FireRequest = FireRequest { url :: String, parameters :: [RequestParameter] }
                 | JSONFireRequest { json :: String, url :: String,  parameters :: [RequestParameter] }

data FireResponse = FireResponse { body :: ByteString, status :: Int, headers :: [Header] }

data FireJWT = FireJWT { v :: Int, iat :: Int, d :: [(String, String)], nbf :: Maybe Int, exp :: Maybe Int, admin :: Maybe Bool, debug :: Maybe Bool }
