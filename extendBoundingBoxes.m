function [ extended ] = extendBoundingBoxes( boundingboxes , nbPixels)
%extendBoundingBoxes extend bounding boxes to add some pixels around it
%   It adds nbPixels in each direction (up, bottom, right, left)
    extended = [];

    for k = 1:size(boundingboxes,1)

        x = floor(boundingboxes(k,1)) - nbPixels;
        y = floor(boundingboxes(k,2)) - nbPixels;
        width = ceil(boundingboxes(k,3)) + nbPixels*2;
        height = ceil(boundingboxes(k,4)) + nbPixels*2;

        
        extended = [extended [x,y,width, height]];

    end 


end

