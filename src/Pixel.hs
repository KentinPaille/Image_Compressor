{-
-- EPITECH PROJECT, 2023
-- Compressor
-- File description:
-- Pixel
-}
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Pixel (Pixel(..), newPixel, showAllPixels) where

import Color (Color)
import Position (Position)

data Pixel = Pixel Position Color deriving (Eq)

instance Show Pixel where
    show (Pixel pos color) = show pos ++ " " ++ show color ++ "\n"

newPixel :: Position -> Color -> Pixel
newPixel = Pixel

showAllPixels :: [Pixel] -> String
showAllPixels [] = ""
showAllPixels [Pixel pos color] = show pos ++ " " ++ show color
showAllPixels (px:pxs) = show px ++ showAllPixels pxs
