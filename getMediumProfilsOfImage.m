function [ mediumProfils ] = getMediumProfilsOfImage( filename,  nbLines, nbCols, nbLinePerProfil, coordSaveFilename)
%getMediumProfilsOfImage Retourne les profils des classes de chiffres de l'image
%pointée par filename

BI = openImage(filename);


[indicesLinesCorrect, indicesCols] = getIndicesOfLinesAndCols(BI, nbLines, nbCols);

%showBoundingBoxesOverImage(BI, indicesLinesCorrect, indicesCols);



coord = buildCoordByLinesCols(indicesLinesCorrect,indicesCols);
display(coord);

%saveCoordToFile(coordSaveFilename, coord );

%boundingboxesExtended = importdata(coordSaveFilename);

profils = determineProfils(BI, coord, nbLinePerProfil);

mediumProfils = calculateCenterOfProfil(profils,nbCols);
%display(centerOfProfils);


end

