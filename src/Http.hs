module Http where

import Control.Lens
import Data.Aeson.Lens (_String, key)
import qualified Data.ByteString.Lazy as BL
import Network.Wreq
import Network.Wreq.Types
import Data.Text (pack)

fireGet :: String -> IO ()
fireGet url = do
                response <- get url
                Prelude.print $ (response ^. responseBody)


