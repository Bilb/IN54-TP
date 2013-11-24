function [ probas ] = calculateProbsKPPV( filenameApp, filenameTest, ...
    nbZonesVert, nbZonesHoriz, nbLigneChiffreApp, nbColsChiffreApp, ...
    nbLigneChiffreTest, nbColsChiffreTest, filenameSaveData, ...
    filenameSaveProbs, k)


%partout où il y a des save : http://www.mathworks.fr/fr/help/matlab/ref/varargin.html
% aussi en tenir compte dans saveToFile !
densiteApp = analyseImageByArea( filenameApp, ...
    nbZonesVert, nbZonesHoriz, nbLigneChiffreApp , nbColsChiffreApp, ...
    filenameSaveData );

densiteTest = analyseImageByArea( filenameTest, ...
    nbZonesVert, nbZonesHoriz, nbLigneChiffreTest , nbColsChiffreTest, ...
    '' );

sizeDensiteTest = size(densiteTest);
sizeDensiteApp = size(densiteApp);


distances = zeros(sizeDensiteTest(1),sizeDensiteApp(1));
for indiceTest=1:sizeDensiteTest(1) 
    
    for indiceApp=1:sizeDensiteApp(1) 
        distance = 0;
        for indiceVert=1:nbZonesVert
            for indiceHoriz=1:nbZonesHoriz
                distance = distance + abs(densiteApp(indiceApp,indiceVert,indiceHoriz) - densiteTest(indiceTest,indiceVert,indiceHoriz)); 
            end
        end

        distances(indiceTest,indiceApp) = distance;
    end    
end

%valueCurrent = 32;


probas = zeros(sizeDensiteTest(1), 10);
sizeD = size(distances);
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
    
   % display('===============================');
   % display(indiceTest);
   % display(nearestNeighbors);
    
    % On remplit la partie associée du vecteur des probas à retourner.
    for indiceProba=1:10
       probas(indiceTest, indiceProba) = (histc(nearestNeighbors(:),indiceProba))/k;
    end
   % display(probas);
end





end

