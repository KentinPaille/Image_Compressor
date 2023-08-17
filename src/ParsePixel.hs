{-
-- EPITECH PROJECT, 2023
-- Compressor
-- File description:
-- ParsePixel
-}

module ParsePixel (parsePixels) where

import Position (Position, newPosition)
import Color (Color(..), newColor)
import Pixel (Pixel(..), newPixel)

parsePosition :: String -> Position
parsePosition str = newPosition x y
  where
    nums = splitTuple str
    x = read (head nums) :: Int
    y = read (nums !! 1) :: Int

parseColor :: String -> Color
parseColor str = newColor r g b
  where
    nums = splitTuple str
    r = read (nums !! 2) :: Int
    g = read (nums !! 3) :: Int
    b = read (nums !! 4) :: Int

splitTuple :: String -> [String]
splitTuple [] = []
splitTuple (c:cs)
  | c `elem` "(), " = splitTuple cs
  | otherwise =
    takeWhile (\x -> x /= ',' && x /= ')') (c:cs) : splitTuple
    (dropWhile (\x -> x /= ',' && x /= ')') (c:cs))

parsePixels :: [String] -> [Pixel]
parsePixels = map (\x -> newPixel (parsePosition x) (parseColor x))
