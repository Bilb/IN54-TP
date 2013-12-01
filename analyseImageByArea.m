function [ results ] = analyseImageByArea( filename, ...
    nbZonesVert, nbZonesHoriz, nbLigneChiffre, nbColsChiffre, ...
    filenameSave )
%analyseImageByArea Analyse une image avec plusieurs chiffres par la
%méthode des zones.
% filename : nom du fichier de l'image
% nbZonesVert : nombres de zones en hauteur (égales)
% nbZonesHoriz : nombres de zones en largeur (égales)
% nbLigneChiffre : nombre de lignes de chiffres
% nbColsChiffre : nombre de colonnes de chiffres
% filenameSave : nom du fichier où sauvegarder le résultat


% Ouverture de l'image binaire
BI = openImage(filename);
[indicesLinesCorrect, indicesCols] = getIndicesOfLinesAndCols(BI, ...
                nbLigneChiffre, nbColsChiffre);

% Transformation des indices de lignes et colonnes en coordonnées type
% haut-gauche et bas-droite
coord = buildCoordByLinesCols(indicesLinesCorrect,indicesCols);

sizeCoord = size(coord);

% Pré allocation
results = zeros(nbLigneChiffre * nbColsChiffre ,nbZonesVert, nbZonesHoriz);

% Pour chacun des chiffre repéré ...
for i=1:sizeCoord(1)
   % ... on analyse par la méthodes des aires
   one_result = analyzePerArea(BI, coord(i,:), nbZonesVert, nbZonesHoriz);
   % et on sauvegarde le résultat dans results à l'endroit qui va bien
   results(i,:,:) = one_result;
end

% a décommenter pour sauvegarder les données du classifieurs par densité
% Afin de le sauvegarder dans un fichier, sans formatage spécifique, il
% faut applatir le résultats en 2D. 
%ret_2d = reshape(results,[nbColsChiffre*10,nbZonesVert * nbZonesHoriz]);

% On peut alors le sauvé tel quel dans le fichier destination
%saveToFile(filenameSave, ret_2d, 'Données du classifieur par densité sauvées !');


end

