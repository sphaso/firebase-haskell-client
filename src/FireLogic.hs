module FireLogic where

import Data.List (find)
import Data.Maybe (isNothing, fromMaybe)
import Types

-- not so straightforward, you can use it with Print?!
-- https://www.firebase.com/docs/rest/guide/retrieving-data.html#section-rest-queries
onlyShallow :: [RequestParameter] -> Bool
onlyShallow opts = (shallowIn && (length opts) == 1) || (not shallowIn)
                    where shallowIn = elem Shallow (map fst opts)

onlyGets :: [RequestParameter] -> Bool
onlyGets opts = and (map (\x -> elem (fst x) getOnly) opts)
                    where getOnly = [Shallow, Callback, Format, Download, Print]

printValue :: [RequestParameter] -> Bool
printValue opts = (isNothing a) || (snda == "pretty") || (snda == "silent")
                    where a = find (\(a,b) -> a == Print) opts
                          snda = snd (fromMaybe (Print, "") a)

orderByValue :: [RequestParameter] -> Bool
orderByValue opts = (isNothing a) || (snda == "$key") || (snda == "$value") || (snda == "$priority")
                    where a = find (\(a,b) -> a == OrderBy) opts
                          snda = snd (fromMaybe (OrderBy, "") a)

anyEmpty :: [RequestParameter] -> Bool
anyEmpty opts = and $ map (\(a,b) -> b /= "") opts

validate :: [RequestParameter] -> Bool
validate = (fmap and . sequence) [anyEmpty, orderByValue, printValue, onlyGets, onlyShallow]

