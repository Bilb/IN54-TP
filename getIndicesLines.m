function [ indices ] = getIndicesLines( BW, n, offset )
% getIndicesLinees : retourne la liste des indices des pixels verticaux où
% un chiffre commence.
% Elle retourne n couples de données se suivant, contenant tour à tour, le
% premier pixel et le dernier d'une ligne.
    
    % On projete les lignes en sommant le nombre de pixels blancs, par
    % lignes
    imageData=sum(BW>0,2);

    lastStop = 1;
    indices = [];
    for i=1:n
        % On cherche le prochain front montant
        edge=find(imageData(lastStop:end), 1, 'first') + lastStop;
        % Puis à partir de là, le prochain front descendant
        fallingEdge=find(imageData(edge:end)==0, 1, 'first') + edge;
        lastStop = fallingEdge;
        % edge - 2 car le edge que l'on trouve c'est le pixel où on est
        % blanc. On retient le pixel d'avant, pour pouvir détourer
        % correctement. Il semble que -1 ne suffise pas...
        indices = [indices, edge-2 + offset, fallingEdge+offset ];
    end
end

