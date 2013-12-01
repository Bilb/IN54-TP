function [ result ] = analyzePerArea(BW, box, nbZonesVert, nbZonesHoriz)
%analyzePerArea Analyse le chiffre par la méthode des zones.
% BW image où se trouve la zone à étudier
% box est la bounding box du chiffre dans l'image
% nbZonesVert : nombres de zones en hauteur (de hauteurs égales)
% nbZonesHoriz : nombres de zones en largeur (de largeurs égales)
% retourne une matrice de nbZonesVert x nbZonesHoriz contenant le nombre de
%   pixels blancs dans chacune des zones réparties uniformément

% On extrait la partie de l'image en question
subImage = BW(box(2):box(4),box(1):box(3));
sizeSubImage = size(subImage);

% On calcul la taille de chaque zones vert/horiz
vertZoneSize = round(sizeSubImage(1)/nbZonesVert);
horizZoneSize = round(sizeSubImage(2)/nbZonesHoriz);

% La première zone va commencer du pixel 1:1 à vertZoneSize:horizZoneSize
vertStart = 1;
horizStart = 1;
vertStop = vertZoneSize;
horizStop = horizZoneSize;

% calcul de la surface de la zone : afin d'avoir une densité de pixels
% blancs, il nous faut le nombre de pixels total
surfaceZone = sizeSubImage(1) * sizeSubImage(2);

% pré initialisation
result = zeros(nbZonesVert, nbZonesHoriz);
% faire pour chaque zone verticales
for i=1:(nbZonesVert)
    % faire pour chaque zone horizontale
    for j=1:(nbZonesHoriz )
        % On extrait les pixels de la zone en question
        zone = subImage(vertStart:vertStop, horizStart:horizStop);
      
        % On somme les éléments de la zone : étant donné que c'est une
        % image binaire, c'est aussi le nombre de pixels blancs de l'image
        ret = sum(zone(:));
        
        % On déplace la fenètre de la zone horiz
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
    
    
    % On passe à la ligne suivante : on augmente le vertical, et on reset
    % l'horizontal
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

