module Types where

type RequestParameter = (QueryParameters, String)

data QueryParameters = Auth | Shallow | Callback | Format | OrderBy | LimitToFirst | LimitToLast | StartAt | EndAt | EqualTo | Print

data FireRequest = FireRequest { url :: String, parameters :: [RequestParameter] }


