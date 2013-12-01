function [ BW ] = openImage( filename )
%openImage Ouvre l'image binaire pointée par filename
%   L'ouvre et l'inverse, afin d'avoir une  image blanc sur noir.

BW = imread(filename);

% Inverse l'image : pour avoir une image blanc sur noir. Utile dans la
% recherche des pixels blancs.
BW=~BW;
end

