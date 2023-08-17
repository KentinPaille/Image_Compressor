# Image Compressor
[K-mean algorithm](https://en.wikipedia.org/wiki/K-means_clustering) applied to image compression.
<br>

## Build
[Stack](https://docs.haskellstack.org/en/stable/README/) and [GNU Make](https://www.gnu.org/software/make/) are used to build the project.

### Makefile
```sh
$> git clone https://github.com/max044/Image_Compressor.git
$> cd Image_Compressor
$> make
```
<br>

## How to use it ?
```sh
$> ./imageCompressor -h
USAGE: ./imageCompressor -n N -l L -f F
      N       number of colors in the final image
      L       convergence limit
      F       path to the file containing the colors of the pixels
```
<br>

## Example
```sh
./imageCompressor -n 4 -l 5 -f ./example.in
```

## Input Format
```sh
$> head example.in
(0,0) (66,20,26)
(0,1) (98,99,233)
(0,2) (45,12,167)
(1,0) (33,16,94)
(1,1) (78,8,9)
(1,2) (20,27,67)
(2,0) (88,77,211)
(2,1) (1,56,37)
(2,2) (15,89,40)
```
The left column is the actual position of a pixel and the right column it's color.
<br>