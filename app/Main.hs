{-
-- EPITECH PROJECT, 2023
-- Compressor
-- File description:
-- Main
-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use unless" #-}
{-# HLINT ignore "Use notElem" #-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Main (main) where

import Lib (usage, printExit, stringSplitter)

import Color (Color(..), newColor)
import Cluster (Cluster(..))
import Pixel (Pixel(..))
import ParseArgs (Conf(..), getOpts)
import ParsePixel (parsePixels)
import Kmeans (kMeans)

import System.Random
import System.Environment (getArgs)
import qualified Control.Monad
import Control.Exception (catch)
import System.Exit (exitWith, ExitCode(ExitFailure), exitSuccess)

main :: IO ()
main = do
    args <- getArgs
    errorHandling args
    let conf = getOpts (Conf 0 0 "" []) args
    case conf of
        Nothing -> printExit "Invalid Arguments"
        Just validConf -> catch (openFile validConf)
            (\e -> print (e :: IOError) >> exitWith (ExitFailure 84))

errorHandling :: [String] -> IO ()
errorHandling args = Control.Monad.when ("-h" `elem` args) usage
    >> Control.Monad.when (null args) (printExit "No args gived")
    >> Control.Monad.when (not ("-n" `elem` args))
        (printExit "No number given")
    >> Control.Monad.when (not ("-l" `elem` args))
        (printExit "No limit given")
    >> Control.Monad.when (not ("-f" `elem` args))
        (printExit "No file given")

openFile :: Conf -> IO ()
openFile conf = do
    file <- readFile (filePath conf)
    let newConf = fillConf conf file
    let pixels = parsePixels (fileContent newConf)
    let clusters = kMeans (setCluster (nbColors conf) (nbColors conf)
                            [] pixels) pixels (convergenceLimit newConf)
    printAllCluster clusters
    exitSuccess

printAllCluster :: [Cluster] -> IO ()
printAllCluster = foldr ((>>) . print) (return ())

setCluster :: Int -> Int -> [Cluster] -> [Pixel] -> [Cluster]
setCluster 0 _ clusters _ = clusters
setCluster nb tmp clusters pixels =
    setCluster (nb - 1) tmp (clusters ++ [Cluster []
    (selectRandomPixel pixels randomNum (length pixels - 1 -
    randomNum) clusters) (newColor 0 0 0)]) pixels
    where randomNum = fst $ randomR (0, length pixels - 1) (mkStdGen (nb*48))

selectRandomPixel :: [Pixel] -> Int -> Int-> [Cluster] -> Color
selectRandomPixel ((Pixel pos color):pxs) 0 tmp cluster =
    if checkClusterColor cluster color
    then color
    else selectRandomPixel (Pixel pos color:pxs) randomNum tmp cluster
     where randomNum = fst $ randomR (0, tmp) (mkStdGen tmp)
selectRandomPixel (_:pxs) nb cls tmp = selectRandomPixel pxs (nb - 1) cls tmp

checkClusterColor :: [Cluster] -> Color -> Bool
checkClusterColor [] _ = True
checkClusterColor ((Cluster _ color _):cls) color2 =
    (color /= color2) && checkClusterColor cls color2

fillConf :: Conf -> String -> Conf
fillConf conf file = conf { fileContent = stringSplitter file }
