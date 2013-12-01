function [ probas ] = calculateProbsKPPV( filenameApp, filenameTest, ...
    nbZonesVert, nbZonesHoriz, nbLigneChiffreApp, nbColsChiffreApp, ...
    nbLigneChiffreTest, nbColsChiffreTest, filenameSaveData, ...
    filenameSaveProbs, k)
%calculateProbsKPPV calcules les probas des chiffres de l'image par la
%méthode densité + KPPV
% filenameApp nom du fichier de l'image d'apprentissage
% filenameTest nom du fichier de l'image de test
% nbZonesVert nombre de zones verticales pour la densité
% nbZonesHoriz nombre de zones horizontales pour la densité
% nbLigneChiffreApp nombre de lignes de chiffres dans le fichier de base
% nbColsChiffreApp nombre de cols de chiffres dans le fichier de base
% nbLigneChiffreTest bre de lignes de chiffres dans le fichier de test
% nbColsChiffreTest bre de cols de chiffres dans le fichier de test
% filenameSaveData 
% filenameSaveProbs
% k le k de la méthode KPPV
    
% On détermine les densité de l'image d'apprentissage
densiteApp = analyseImageByArea( filenameApp, ...
    nbZonesVert, nbZonesHoriz, nbLigneChiffreApp , nbColsChiffreApp, ...
    filenameSaveData );

% de même avec l'image de tests
densiteTest = analyseImageByArea( filenameTest, ...
    nbZonesVert, nbZonesHoriz, nbLigneChiffreTest , nbColsChiffreTest, ...
    '' );

sizeDensiteTest = size(densiteTest);
sizeDensiteApp = size(densiteApp);

% Pré init
distances = zeros(sizeDensiteTest(1),sizeDensiteApp(1));
% Pour chacun des chiffre à classifié
for indiceTest=1:sizeDensiteTest(1) 
    % on va le comparer avec tout les chiffres de la base d'apprentissage
    for indiceApp=1:sizeDensiteApp(1) 
        distance = 0;
        % On somme les distances pour toutes les zones de ce chiffre
        for indiceVert=1:nbZonesVert
            for indiceHoriz=1:nbZonesHoriz
                distance = distance + abs(densiteApp(indiceApp,indiceVert,indiceHoriz) - densiteTest(indiceTest,indiceVert,indiceHoriz)); 
            end
        end

        distances(indiceTest,indiceApp) = distance;
    end    
end

% Ici, on a dans distances les distances séparant chacuns des chiffres de
% l'image de test vis à vis des chiffre de la base d'apprentissage
probas = zeros(sizeDensiteTest(1), 10);
sizeD = size(distances);

% Application de la méthode des KPPV
for indiceTest=1:sizeD(1)
    
    nearestNeighbors = zeros(k,2);
    
    %Initialisation du vecteurs des plus proches voisins avec les premieres
    %valeurs associées à cette ligne
    for indiceRemplissage=1:k
        nearestNeighbors(indiceRemplissage,1) = floor(((indiceRemplissage-1)/20)+1);
        nearestNeighbors(indiceRemplissage,2) = distances(indiceTest, indiceRemplissage);
    end
    
    % On remplace le voisin le plus éloigné par celui que l'on trouve si il
    % est plus proche que celui-ci.
    for indiceTestCol=(k+1):sizeD(2)
        [maxNeighbord, idx] = max(nearestNeighbors(:,2));


        if distances(indiceTest,indiceTestCol) < maxNeighbord
            nearestNeighbors(idx,1) = (floor((indiceTestCol-1)/20)+1);
            nearestNeighbors(idx,2) = distances(indiceTest,indiceTestCol);
        end
    end
    
    % On remplit la partie associée du vecteur des probas à retourner.
    for indiceProba=1:10
       probas(indiceTest, indiceProba) = (histc(nearestNeighbors(:),indiceProba))/k;
    end
end


saveToFile(filenameSaveProbs, probas, 'Probas du classifieur par densité sauvées !');
end

