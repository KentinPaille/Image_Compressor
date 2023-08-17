{-
-- EPITECH PROJECT, 2023
-- Compressor
-- File description:
-- Kmeans
-}

{-# OPTIONS_GHC -Wno-type-defaults #-}

module Kmeans (kMeans) where

import Cluster (Cluster(..))
import Pixel (Pixel(..))
import Color ( Color(..), newColor)

kMeans :: [Cluster] -> [Pixel] -> Float -> [Cluster]
kMeans cluster pixels limit =
    let newClusters = meanPixelCluster(findCluster
                    (setClusterEmpty cluster) pixels)
    in if findLimit newClusters limit
        then newClusters
        else kMeans newClusters pixels limit

findLimit :: [Cluster] -> Float -> Bool
findLimit [] _ = True
findLimit ((Cluster _ newAverageColor oldAverageColor):cls) limit
    | distance newAverageColor oldAverageColor > limit = False
    | otherwise = findLimit cls limit

setClusterEmpty :: [Cluster] -> [Cluster]
setClusterEmpty [] = []
setClusterEmpty ((Cluster _ newAverageColor oldAverageColor):cls) =
    Cluster [] newAverageColor oldAverageColor : setClusterEmpty cls

meanPixelCluster :: [Cluster] -> [Cluster]
meanPixelCluster [] = []
meanPixelCluster ((Cluster [] newAverageColor _):cls) =
    Cluster [] (meanPixel [] newAverageColor 0)
    newAverageColor : meanPixelCluster cls
meanPixelCluster ((Cluster pixel newAverageColor _):cls) =
    Cluster pixel (meanPixel pixel (newColor 0 0 0) 0)
    newAverageColor : meanPixelCluster cls

meanPixel :: [Pixel] -> Color-> Int-> Color
meanPixel [] (Color r2 g2 b2) 0 = Color (r2 `div` 1)
                (g2 `div` 1) (b2 `div` 1)
meanPixel [] (Color r2 g2 b2) nb = Color (r2 `div` nb)
                (g2 `div` nb) (b2 `div` nb)
meanPixel ((Pixel _ (Color r1 g1 b1)):pxs) (Color r2 g2 b2) nb =
    meanPixel pxs (Color (r1 + r2) (g1 + g2) (b1 + b2)) (nb + 1)


findCluster :: [Cluster] -> [Pixel] -> [Cluster]
findCluster = foldl (\ clusters px
    -> setClusterPixel clusters px (findNearCluster clusters px 999999.0 0 0))

findNearCluster :: [Cluster] -> Pixel -> Float -> Int -> Int -> Int
findNearCluster [] _ _ res _ = res
findNearCluster ((Cluster _ averageColor _):cls) (Pixel position color)
                            dist res tmp
                | dist > distance color averageColor =
                    findNearCluster cls (Pixel position color)
                    (distance color averageColor) tmp (tmp + 1)
                | otherwise = findNearCluster cls (Pixel position color)
                    dist res (tmp + 1)

setClusterPixel :: [Cluster] -> Pixel -> Int -> [Cluster]
setClusterPixel [] _ _ = []
setClusterPixel ((Cluster pxs averageColor oldAverageColor):cls) px 0 =
                    Cluster (pxs ++ [px]) averageColor
                    oldAverageColor : setClusterPixel cls px (-1)
setClusterPixel ((Cluster pxs averageColor oldAverageColor):cls) px tmp =
                    Cluster pxs averageColor
                    oldAverageColor : setClusterPixel cls px (tmp - 1)

distance :: Color -> Color -> Float
distance (Color r1 g1 b1) (Color r2 g2 b2) =
    sqrt (fromIntegral ((r1 - r2) ^ 2 + (g1 - g2) ^ 2 + (b1 - b2) ^ 2))
