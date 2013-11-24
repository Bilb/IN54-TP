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



BI = openImage(filename);
[indicesLinesCorrect, indicesCols] = getIndicesOfLinesAndCols(BI, ...
                nbLigneChiffre, nbColsChiffre);

coord = buildCoordByLinesCols(indicesLinesCorrect,indicesCols);
%display(coord);

sizeCoord = size(coord);


results = zeros(nbLigneChiffre * nbColsChiffre ,nbZonesVert, nbZonesHoriz);

for i=1:sizeCoord(1)
   one_result = analyzePerArea(BI, coord(i,:), nbZonesVert, nbZonesHoriz);
   results(i,:,:) = one_result;
end


%ret_2d = reshape(results,[200,25]);
%saveToFile(filenameSave, ret_2d, 'Données du classifieur par densité sauvées !');


end

