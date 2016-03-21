module FireLogic where

import Data.List (find)
import Data.Maybe (isNothing, fromMaybe)
import Types

onlyShallow :: [RequestParameter] -> Bool
onlyShallow opts | (shallowIn && (length opts) == 1) || (not shallowIn) = True
                 | otherwise = error "Shallow must be the only parameter"
                    where shallowIn = elem Shallow (map fst opts)

onlyGets :: [RequestParameter] -> Bool
onlyGets opts | and (map (\x -> elem (fst x) getOnly) opts) = True
              | otherwise = error "Some parameters are not GET parameters"
                    where getOnly = [Shallow, Callback, Format, Download, Print]

printValue :: [RequestParameter] -> Bool
printValue opts | (isNothing a) || (snda == "pretty") || (snda == "silent") = True
                | otherwise = error "Print argument not recognized: it should be either pretty or silent"
                    where a = find (\(a,b) -> a == Print) opts
                          snda = snd (fromMaybe (Print, "") a)

orderByValue :: [RequestParameter] -> Bool
orderByValue opts | (isNothing a) || (snda == "$key") || (snda == "$value") || (snda == "$priority") = True
                  | otherwise = error "Order argument not recognized: it shuold be either $key, $value or $priority"
                    where a = find (\(a,b) -> a == OrderBy) opts
                          snda = snd (fromMaybe (OrderBy, "") a)

anyEmpty :: [RequestParameter] -> Bool
anyEmpty opts | and $ map (\(a,b) -> b /= "") opts = True
              | otherwise = error "Some arguments are empty"

validate :: [RequestParameter] -> Bool
validate xs = all ($ xs) [anyEmpty, orderByValue, printValue, onlyGets, onlyShallow]

