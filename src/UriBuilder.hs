module UriBuilder where

import Types

queryParsTranslation :: [(QueryParameter, String)]
queryParsTranslation = [(Auth, "auth"), (Shallow, "shallow"), (Callback, "callback"), (Format, "format"), (OrderBy, "orderby"), (LimitToFirst, "limittofirst"), (LimitToLast, "limittolast"), (StartAt, "startat"), (EndAt, "endat"), (EqualTo, "equalto"), (Print, "print"), (Download, "download")]

findParameter :: QueryParameter -> String
findParameter a = snd . head $ filter ((==a) . fst) queryParsTranslation

buildParameters :: [RequestParameter] -> String
buildParameters qp = concat $ map (\(a, b) -> concat [findParameter a, "=", b, "&"]) qp
