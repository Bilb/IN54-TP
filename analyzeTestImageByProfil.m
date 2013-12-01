function [ proba ] = analyzeTestImageByProfil( filenameTest,  ...
    nbLinesTest, nbColsTest, nbLinePerProfil, profilsMedium, probaFilenameSave)
%analyzeTestImageByProfil Analyse l'image de test pour évaluer les
%résultats par rapport aux profils passé en paramètres.
% filenameTest nom du fichier contenant l'image de test
% nbLinesTest nombre de lignes de chiffres dans l'image de test
% nbColsTest nombre de cols de chiffres dans l'image de test
% nbLinePerProfil nombre de lignes par profils de chiffre
% profilsMedium matrice contenant les profils médium issues de l'analyse de
%                           l'image d'apprentissage


    % Ouvre l'image binaire
    BI_test = openImage(filenameTest);

    % Extrait les lignes et colonnes de chiffres
    [indicesLinesCorrect_test, indicesCols_test] = getIndicesOfLinesAndCols(BI_test, ...
        nbLinesTest,nbColsTest);

    %showBoundingBoxesOverImage(BI_test, indicesLinesCorrect_test, indicesCols_test);

    % Les transforme en position haut-gauche, bas-droite
    coord_test = buildCoordByLinesCols(indicesLinesCorrect_test,indicesCols_test);
    
    % Détermine les profils de l'ensemble des chiffres
    profils_test = determineProfils(BI_test, coord_test, nbLinePerProfil);
    
    
    size_profils_test = size(profils_test);
    size_profilsMedium = size(profilsMedium);

    %nbCorrect = 0;
    % Pré initialisation
    proba = zeros(size_profils_test(1)/nbColsTest, size_profilsMedium(1));
    
    
    for i=1:size_profils_test
        profil = profils_test(i,:);
        
        distances = zeros(size_profilsMedium(1), 1);

        for j=1:(size_profilsMedium(1))
           distance = norm(profil - profilsMedium(j,:)); 
           distances(j,1) = distance;
        end
        
        for j=1:(size_profilsMedium(1))
           sumDistance = 0;
           
           for k=0:9 
                sumDistance = sumDistance + exp(-distances(k+1,1));
           end
           
           
           prob = exp(-distances(j,1))/(sumDistance);
           proba(i,j) = prob;
        end

    end
    
    
end

