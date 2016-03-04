module Types where

import Data.ByteString.Lazy

type RequestParameter = (QueryParameter, String)

data QueryParameter = Auth | Shallow | Callback | Format | OrderBy | LimitToFirst | LimitToLast | StartAt | EndAt | EqualTo | Print | Download deriving (Eq)

data FireRequest = FireRequest { url :: String, parameters :: [RequestParameter] }

data FireResponse = FireResponse { body :: ByteString, status :: Int }
