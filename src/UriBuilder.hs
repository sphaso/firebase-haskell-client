module UriBuilder where

import Types

buildParameters :: [RequestParameter] -> String
buildParameters qp = concat $ map (\(a, b) -> concat [show a, "=", b, "&"]) qp
