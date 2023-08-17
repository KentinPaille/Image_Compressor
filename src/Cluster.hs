{-
-- EPITECH PROJECT, 2023
-- Compressor
-- File description:
-- Cluster
-}

module Cluster (Cluster(..), AverageColor, OldAverageColor, showAllClusters) where

import Color (Color(..))
import Pixel (Pixel(..), showAllPixels)

type AverageColor = Color
type OldAverageColor = Color

data Cluster = Cluster [Pixel] AverageColor OldAverageColor deriving (Eq)

instance Show Cluster where
    show (Cluster pixels averageColor _) = "--\n" ++ show averageColor ++ "\n-\n" ++ showAllPixels pixels

showAllClusters :: [Cluster] -> String
showAllClusters = concatMap show
