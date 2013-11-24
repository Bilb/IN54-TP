function [ result ] = analyzePerArea(BW, box, nbZonesVert, nbZonesHoriz)
%analyzePerArea Analyse le chiffre par la méthode des zones.
% coord sont les coordonnées du chiffre dans l'image
% BW image où se trouve la zone à étudier
% nbZonesVert : nombres de zones en hauteur (égales)
% nbZonesHoriz : nombres de zones en largeur (égales)
% retourne une matrice de nbZonesVert x nbZonesHoriz contenant le nombre de
%   pixels blancs dans chacune des zones réparties uniformément


subImage = BW(box(2):box(4),box(1):box(3));
sizeSubImage = size(subImage);

vertZoneSize = round(sizeSubImage(1)/nbZonesVert);
horizZoneSize = round(sizeSubImage(2)/nbZonesHoriz);


vertStart = 1;
horizStart = 1;
vertStop = vertZoneSize;
horizStop = horizZoneSize;

surfaceZone = sizeSubImage(1) * sizeSubImage(2);

result = zeros(nbZonesVert, nbZonesHoriz);
for i=1:(nbZonesVert)
    for j=1:(nbZonesHoriz )
        
        zone = subImage(vertStart:vertStop, horizStart:horizStop);
      
        % On somme les éléments de la zone : étant donné que c'est une
        % image binaire, c'est aussi le nombre de pixels blancs de l'image
        ret = sum(zone(:));
      
        horizStart = horizStart + horizZoneSize;
        horizStop = horizStop + horizZoneSize;
        
        % Si on est dans la dernière zone, on s'assure de terminer sur le
        % dernier pixel de celle ci
        if horizStart + horizZoneSize > sizeSubImage(2)
            horizStop = sizeSubImage(2) - 1;
        end
        
        % On normalise la mesure, car tout les chiffres n'ont pas la même
        % taille
        result(i,j) = (ret*100)/surfaceZone;
        
    end
    
    
    
    vertStart = vertStop + 1;
    horizStart = 1;
    vertStop = vertStop + vertZoneSize;
    horizStop = horizZoneSize;
    
    % Si on est dans la dernière zone, on s'assure de terminer sur le
    % dernier pixel de celle ci
    if vertStart + vertZoneSize > sizeSubImage(1)
            vertStop = sizeSubImage(1) - 1;
    end
end



end

