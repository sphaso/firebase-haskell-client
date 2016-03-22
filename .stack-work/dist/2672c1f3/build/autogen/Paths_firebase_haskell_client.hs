module Paths_firebase_haskell_client (
    version,
    getBinDir, getLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\rolan\\Desktop\\haskell-firebase-client\\.stack-work\\install\\f97f2598\\bin"
libdir     = "C:\\Users\\rolan\\Desktop\\haskell-firebase-client\\.stack-work\\install\\f97f2598\\lib\\x86_64-windows-ghc-7.10.3\\firebase-haskell-client-0.1.0.0-GFtzsF0FbJDCuStYkZTIBi"
datadir    = "C:\\Users\\rolan\\Desktop\\haskell-firebase-client\\.stack-work\\install\\f97f2598\\share\\x86_64-windows-ghc-7.10.3\\firebase-haskell-client-0.1.0.0"
libexecdir = "C:\\Users\\rolan\\Desktop\\haskell-firebase-client\\.stack-work\\install\\f97f2598\\libexec"
sysconfdir = "C:\\Users\\rolan\\Desktop\\haskell-firebase-client\\.stack-work\\install\\f97f2598\\etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "firebase_haskell_client_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "firebase_haskell_client_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "firebase_haskell_client_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "firebase_haskell_client_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "firebase_haskell_client_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
