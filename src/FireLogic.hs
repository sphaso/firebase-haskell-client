module FireLogic where

import Data.List (find)
import Data.Maybe (isNothing, fromMaybe)
import Types

onlyShallow :: [RequestParameter] -> Bool
onlyShallow opts | (shallowIn && (length opts) == 1) || (not shallowIn) = True
                 | otherwise = error "Shallow must be the only parameter"
                    where shallowIn = elem Shallow (map fst opts)

-- This is just... wrong!
--onlyGets :: [RequestParameter] -> Bool
--onlyGets opts | and (map (\x -> elem (fst x) getOnly) opts) = True
--              | otherwise = error "Some parameters are not GET parameters"
--                    where getOnly = [Shallow, Callback, Format, Download, Print]

-- Can orderBy and limits be used with POST \ PUT etc.?
onlyGet :: [RequestParameter] -> Bool
onlyGet opts | or (map (\x -> elem (fst x) getOnly) opts) = True
             | otherwise = error "Some parameters are only GET parameters"
                   where getOnly = [Shallow, Callback, Format, Download]

printValue :: [RequestParameter] -> Bool
printValue opts | (isNothing a) || (snda == "pretty") || (snda == "silent") = True
                | otherwise = error "Print argument not recognized: it should be either pretty or silent"
                    where a = find (\(a,b) -> a == Print) opts
                          snda = snd (fromMaybe (Print, "") a)

printValueSilent :: [RequestParameter] -> Bool
printValueSilent opts | (isNothing a) || (snda == "pretty") = True
                      | otherwise = error "Print argument not recognized or not allowed for this verb"
                           where a = find (\(a,b) -> a == Print) opts
                                 snda = snd (fromMaybe (Print, "") a)

orderByValue :: [RequestParameter] -> Bool
orderByValue opts | (isNothing a) || (snda == "$key") || (snda == "$value") || (snda == "$priority") = True
                  | otherwise = error "Order argument not recognized: it should be either $key, $value or $priority"
                    where a = find (\(a,b) -> a == OrderBy) opts
                          snda = snd (fromMaybe (OrderBy, "") a)

anyEmpty :: [RequestParameter] -> Bool
anyEmpty opts | and $ map (\(a,b) -> b /= "") opts = True
              | otherwise = error "Some arguments are empty"

validateGet :: [RequestParameter] -> Bool
validateGet xs = all ($ xs) [anyEmpty, orderByValue, printValue, onlyShallow]

validatePost :: [RequestParameter] -> Bool
validatePost xs = all ($ xs) [anyEmpty, onlyGet, printValue]

validateDelete :: [RequestParameter] -> Bool
validateDelete xs = all ($ xs) [anyEmpty, printValueSilent]

validatePut :: [RequestParameter] -> Bool
validatePut xs = all ($ xs) [anyEmpty]

validatePatch :: [RequestParameter] -> Bool
validatePatch xs = all ($ xs) [anyEmpty]

