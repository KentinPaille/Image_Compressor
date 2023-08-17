{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_imageCompressor (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/durbaon/delivery/Haskell/Compressor_bo/.stack-work/install/x86_64-linux/0c26b2d52a61ede746c7cb7be36c552d423591e3eeb1eeb36d25fa172fd408b4/9.2.5/bin"
libdir     = "/home/durbaon/delivery/Haskell/Compressor_bo/.stack-work/install/x86_64-linux/0c26b2d52a61ede746c7cb7be36c552d423591e3eeb1eeb36d25fa172fd408b4/9.2.5/lib/x86_64-linux-ghc-9.2.5/imageCompressor-0.1.0.0-5IFLITI7C5P3SELT32Rj5h-imageCompressor-exe"
dynlibdir  = "/home/durbaon/delivery/Haskell/Compressor_bo/.stack-work/install/x86_64-linux/0c26b2d52a61ede746c7cb7be36c552d423591e3eeb1eeb36d25fa172fd408b4/9.2.5/lib/x86_64-linux-ghc-9.2.5"
datadir    = "/home/durbaon/delivery/Haskell/Compressor_bo/.stack-work/install/x86_64-linux/0c26b2d52a61ede746c7cb7be36c552d423591e3eeb1eeb36d25fa172fd408b4/9.2.5/share/x86_64-linux-ghc-9.2.5/imageCompressor-0.1.0.0"
libexecdir = "/home/durbaon/delivery/Haskell/Compressor_bo/.stack-work/install/x86_64-linux/0c26b2d52a61ede746c7cb7be36c552d423591e3eeb1eeb36d25fa172fd408b4/9.2.5/libexec/x86_64-linux-ghc-9.2.5/imageCompressor-0.1.0.0"
sysconfdir = "/home/durbaon/delivery/Haskell/Compressor_bo/.stack-work/install/x86_64-linux/0c26b2d52a61ede746c7cb7be36c552d423591e3eeb1eeb36d25fa172fd408b4/9.2.5/etc"

getBinDir     = catchIO (getEnv "imageCompressor_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "imageCompressor_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "imageCompressor_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "imageCompressor_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "imageCompressor_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "imageCompressor_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
