{-
-- EPITECH PROJECT, 2023
-- Compressor
-- File description:
-- Lib
--}

module Lib (usage, printExit, stringSplitter) where

import System.Exit (exitWith, ExitCode(ExitFailure))

usage :: IO()
usage = putStrLn "USAGE: ./imageCompressor -n N -l L -f F\n"
     >> putStr "      N"
     >> putStrLn "       number of colors in the final image"
     >> putStr "      L"
     >> putStrLn "       convergence limit"
     >> putStr "      F"
     >> putStrLn "       path to the file containing the colors of the pixels"
     >> exitWith (ExitFailure 0)

printExit :: String -> IO ()
printExit msg = putStrLn msg >> exitWith (ExitFailure 84)

stringSplitter :: String -> [String]
stringSplitter str = splitString str '\n' []

splitString :: String -> Char -> [String] -> [String]
splitString "" _ acc = acc
splitString str char acc =
     let (word, rest) = break (== char) str
     in case rest of
           [] -> acc ++ [word]
           _ -> splitString (tail rest) char (acc ++ [word])
