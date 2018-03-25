module Paths_hogelang (
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

bindir     = "/home/hogehiko/.cabal/bin"
libdir     = "/home/hogehiko/.cabal/lib/x86_64-linux-ghc-7.10.3/hogelang-0.1.0.0-0WjKcnoho3lEvLT0yktPQR"
datadir    = "/home/hogehiko/.cabal/share/x86_64-linux-ghc-7.10.3/hogelang-0.1.0.0"
libexecdir = "/home/hogehiko/.cabal/libexec"
sysconfdir = "/home/hogehiko/.cabal/etc"

getBinDir, getLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "hogelang_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "hogelang_libdir") (\_ -> return libdir)
getDataDir = catchIO (getEnv "hogelang_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "hogelang_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "hogelang_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
