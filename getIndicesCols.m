function [ indices ] = getIndicesCols( BW_t, numberOfColsToFind )
%getIndicesCols Retourne les indices correspondant aux colonnes où
%commencent les chiffres.


    imageData=sum(BW_t>0,2);
    
    lastStop = 1;
    indices = [];
    for i=1:numberOfColsToFind
        edge=find(imageData(lastStop:end), 1, 'first') + lastStop;
        fallingEdge=find(imageData(edge:end)==0, 1, 'first') + edge;
        lastStop = fallingEdge;
        indices = [indices [edge-2, fallingEdge] ];
    end

end

