{-
-- EPITECH PROJECT, 2023
-- Compressor
-- File description:
-- ParseArgs
-}

module ParseArgs (Conf(..), getOpts) where

import Text.Read (readMaybe)

data Conf = Conf {
    nbColors :: Int,
    convergenceLimit :: Float,
    filePath :: String,
    fileContent :: [String]
}

getOpts :: Conf -> [String] -> Maybe Conf
getOpts conf args = case parseArgs conf args of
    Left _ -> Nothing
    Right newConf -> Just newConf

parseArgs :: Conf -> [String] -> Either String Conf
parseArgs conf [] = Right conf
parseArgs conf (arg:args) = case arg of
    "-n" -> parseNumber conf args
    "-l" -> parseLimit conf args
    "-f" -> parseFile conf args
    _ -> Left "Invalid argument"

parseNumber :: Conf -> [String] -> Either String Conf
parseNumber _ [] = Left "Missing argument for -n"
parseNumber conf (value:rest) = case readMaybe value of
    Nothing -> Left "Provided number is invalid"
    Just nb -> if nb < 1
        then Left "Provided number is too low"
        else parseArgs conf {nbColors = nb} rest

parseLimit :: Conf -> [String] -> Either String Conf
parseLimit _ [] = Left "Missing argument for -l"
parseLimit conf (value:rest) = case readMaybe value of
    Nothing -> Left "Provided number is invalid"
    Just nb -> if nb < 0
        then Left "Provided number is too low"
        else parseArgs conf {convergenceLimit = nb} rest

parseFile :: Conf -> [String] -> Either String Conf
parseFile _ [] = Left "Missing argument for -f"
parseFile conf (value:rest) = parseArgs conf {filePath = value} rest
