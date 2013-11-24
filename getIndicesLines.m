function [ indices ] = getIndicesLines( BW, n, offset )
% getIndicesLinees : retourne la liste des indices des pixels verticaux où
% un chiffre commence.
% Elle retourne n couples de données se suivant, contenant tour à tour, le
% premier pixel et le dernier d'une ligne.

    imageData=sum(BW>0,2);

    %plot(imageData);
    lastStop = 1;
    indices = [];
    for i=1:n
        edge=find(imageData(lastStop:end), 1, 'first') + lastStop;
        fallingEdge=find(imageData(edge:end)==0, 1, 'first') + edge;
        lastStop = fallingEdge;
        % edge - 2 car le edge que l'on trouve c'est le pixel où on est
        % blanc. On retient le pixel d'avant, pour pouvir détourer
        % correctement. Il semble que -1 ne suffise pas...
        indices = [indices, edge-2 + offset, fallingEdge+offset ];
    end
end

