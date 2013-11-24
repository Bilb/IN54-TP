function [ proba ] = analyzeTestImageByProfil( filenameTest,  ...
    nbLinesTest, nbColsTest, nbLinePerProfil, profilsMedium)
%analyzeTestImageByProfil Analyse l'image de test pour évaluer les
%résultats par rapport aux profils passé en paramètres.


    % BI_test : binary image à tester
    BI_test = openImage(filenameTest);

    
    [indicesLinesCorrect_test, indicesCols_test] = getIndicesOfLinesAndCols(BI_test, ...
        nbLinesTest,nbColsTest);

    %showBoundingBoxesOverImage(BI_test, indicesLinesCorrect_test, indicesCols_test);

    coord_test = buildCoordByLinesCols(indicesLinesCorrect_test,indicesCols_test);
    profils_test = determineProfils(BI_test, coord_test, nbLinePerProfil);
    
    
    size_profils_test = size(profils_test);
    size_profilsMedium = size(profilsMedium);

    %nbCorrect = 0;

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
        
        
        
        
        
        
%        [~,indice_min] = min(distances);
%        classDetected = indice_min-1;
%        realClass = floor(i/NB_LIGNES_CHIFFRES_IMAGE_LEARN);
%        if(realClass == classDetected)
%            nbCorrect = nbCorrect + 1;
%        end

    end
    
    %saveToFile(PROBA_PROFILS_SAVE_FILENAME, proba, 'Probabilités des résultats de la méthodes des profils sauvées');


    %ratio = nbCorrect * 100 / NB_CHIFFRES_IMAGE_TEST;
    %display(ratio);



end

