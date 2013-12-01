function [ mediumProfils ] = getMediumProfilsOfImage( filename,  nbLines,...
    nbCols, nbLinePerProfil, coordSaveFilename)
%getMediumProfilsOfImage Retourne les profils des classes de chiffres de l'image
%pointée par filename
% filename nom du fichier de l'image source
% nbLines nombre de ligne à trouver
% nbCols nombre de colonnes à trouver
% nbLinePerProfil nombre de ligne par profils
% coordSaveFilename nom du fichier où sauver les coordonnées

BI = openImage(filename);


[indicesLinesCorrect, indicesCols] = getIndicesOfLinesAndCols(BI, nbLines, nbCols);

%showBoundingBoxesOverImage(BI, indicesLinesCorrect, indicesCols);

% Obtention des coordonnées sous forme de la position haut-gauche et
% bas-droite
coord = buildCoordByLinesCols(indicesLinesCorrect,indicesCols);

%saveCoordToFile(coordSaveFilename, coord );

% On calcul les profils de tout les chiffres de cette image
profils = determineProfils(BI, coord, nbLinePerProfil);

% Puis les profils médian
mediumProfils = calculateCenterOfProfil(profils,nbCols);


end

