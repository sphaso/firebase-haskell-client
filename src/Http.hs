{-# LANGUAGE OverloadedStrings #-}

module Http where

import Control.Lens
import Data.Aeson
import Data.Aeson.Lens (_String, key)
import qualified Data.ByteString.Lazy as BL
import Network.Wreq as WR (get, post, delete, put, customPayloadMethod,
                           responseBody, responseStatus, statusCode, responseHeaders)
import Network.Wreq.Types
import Data.Text (pack)
import Types
import FireLogic
import UriBuilder

--TODO possibly extract helper function of the last line which is reused in all HTTP operator functions


get :: FireRequest -> IO FireResponse
get (FireRequest url opts) = do
                                let validation = validateGet opts
                                let pars = buildParameters opts
                                response <- WR.get (url ++ "?" ++ pars)
                                return $ FireResponse (response ^. WR.responseBody) (response ^. WR.responseStatus . WR.statusCode) (response ^. WR.responseHeaders)

post :: FireRequest -> IO FireResponse
post (JSONFireRequest json url opts) = do
                                        let validation = validatePost opts
                                        let pars = buildParameters opts
                                        response <- WR.post (url ++ "?" ++ pars) (toJSON json)
                                        return $ FireResponse (response ^. WR.responseBody) (response ^. WR.responseStatus . WR.statusCode) (response ^. WR.responseHeaders)

delete :: FireRequest -> IO FireResponse
delete (FireRequest url opts) = do
                                    let validation = validateDelete opts
                                    let pars = buildParameters opts
                                    response <- WR.delete (url ++ "?" ++ pars)
                                    return $ FireResponse (response ^. WR.responseBody) (response ^. WR.responseStatus . WR.statusCode) (response ^. WR.responseHeaders)

patch :: FireRequest -> IO FireResponse
patch (JSONFireRequest json url opts) = do
                                        let validation = validatePatch opts
                                        let pars = buildParameters opts
                                        response <- WR.customPayloadMethod "PATCH" (url ++ "?" ++ pars) (toJSON json)
                                        return $ FireResponse (response ^. WR.responseBody) (response ^. WR.responseStatus . WR.statusCode) (response ^. WR.responseHeaders)

put :: FireRequest -> IO FireResponse
put (JSONFireRequest json url opts) = do
                                        let validation = validatePut opts
                                        let pars = buildParameters opts
                                        response <- WR.put (url ++ "?" ++ pars) (toJSON json)
                                        return $ FireResponse (response ^. WR.responseBody) (response ^. WR.responseStatus . WR.statusCode) (response ^. WR.responseHeaders)