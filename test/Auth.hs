
module Auth where

  import Types
  import System.Environment

  getConf :: IO [String]
  getConf = do
              env <- getEnv "FIREBASE_CONF"
              file <- readFile env
              return $ lines file
