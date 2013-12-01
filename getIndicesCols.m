function [ indices ] = getIndicesCols( BW, numberOfColsToFind )
%getIndicesCols Retourne les indices correspondant aux colonnes où
%commencent les chiffres.
% BW image source
% numberOfColsToFind : nombre de colonnes où l'on s'arrêtera

    % projete les colonnes en sommant le nombre de pixels blancs, par
    % colonnes
    imageData=sum(BW>0,2);
    
    lastStop = 1;
    indices = [];
    for i=1:numberOfColsToFind
        % On cherche le prochain front montant
        edge=find(imageData(lastStop:end), 1, 'first') + lastStop;
        % Puis à partir de là, le prochain front descendant
        fallingEdge=find(imageData(edge:end)==0, 1, 'first') + edge;
        lastStop = fallingEdge;
        indices = [indices [edge-2, fallingEdge] ];
    end

end

