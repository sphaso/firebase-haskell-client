{-# LANGUAGE OverloadedStrings #-}

module Http where

import Control.Lens
import Data.Aeson.Lens (_String, key)
import qualified Data.ByteString.Lazy as BL
import Network.Wreq as WR (get, delete, responseBody, responseStatus, statusCode)
import Network.Wreq.Types
import Data.Text (pack)
import Types
import FireLogic
import UriBuilder

get :: FireRequest -> IO FireResponse
get (FireRequest url opts) = do
                                let validation = validate opts
                                let pars = buildParameters opts
                                response <- WR.get (url ++ "?" ++ pars)
                                return $ FireResponse (response ^. WR.responseBody) (response ^. WR.responseStatus . WR.statusCode)

delete :: String -> IO FireResponse
delete url = do
                response <- WR.delete url
                return $ FireResponse (response ^. WR.responseBody) (response ^. WR.responseStatus . WR.statusCode)
