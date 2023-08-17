{-
-- EPITECH PROJECT, 2023
-- Compressor
-- File description:
-- Color
-}

module Color (Color(..), newColor) where

data Color = Color Int Int Int deriving (Eq)

instance Show Color where
    show (Color r g b) = "(" ++ show r ++ "," ++ show g ++ "," ++ show b ++ ")"

newColor :: Int -> Int -> Int -> Color
newColor = Color
