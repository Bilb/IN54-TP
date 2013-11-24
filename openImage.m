function [ BW ] = openImage( filename )
%openImage Ouvre l'image binaire pointée par filename
%   L'ouvre et l'inverse, afin d'avoir une  image blanc sur noir.

BW = imread(filename);

BW=~BW;
end

