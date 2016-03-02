{-# LANGUAGE OverloadedStrings #-}

module Http where

import Control.Lens
import Data.Aeson.Lens (_String, key)
import qualified Data.ByteString.Lazy as BL
import Network.Wreq as WR (get, responseBody)
import Network.Wreq.Types
import Data.Text (pack)
import Types

get :: FireRequest -> IO ()
get (FireRequest url opts) = do
                                response <- WR.get url
                                Prelude.print $ (response ^. WR.responseBody)

