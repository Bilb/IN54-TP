function [ boundingboxes ] = getBoundingBoxes( BW )
%getBoundingBoxes Retourne une liste des boundingBox des nombres de
%l'image
%   BW : the binary image, white over black

bb  = regionprops(BW, {'BoundingBox'});
boundingboxes = cat(1, bb.BoundingBox);

end

