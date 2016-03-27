module UriBuilder where

import Data.List
import Types

buildParameters :: [RequestParameter] -> String
buildParameters qp = intercalate "&" $ map (\(a, b) -> concat [show a, "=", b]) qp
