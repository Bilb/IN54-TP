function [ probas ] = analyzeNumbersByProfils(filenameLearn, ...
nbLinesLearn,nbColsLearn, ...
nbLinePerProfil, filenameSaveCoord, filenameTest, ...
nbLinesTest, nbColsTest )
%analyzeNumbersByProfils Analyse les chiffres par la méthode des profils.


    %display(NB_LINE_PER_PROFIL);

    

    profilsMedium = getMediumProfilsOfImage(filenameLearn, ...
        nbLinesLearn, nbColsLearn, ...
        nbLinePerProfil, filenameSaveCoord);
    
    %saveToFile(PROFILS_SAVE_FILENAME, profilsMedium, 'Profils médians sauvés');
    
    probas = analyzeTestImageByProfil( filenameTest,  ...
    nbLinesTest, nbColsTest, nbLinePerProfil, profilsMedium );

    %display(probas);
    size_proba = size(probas);
    
    nbCorrect = 0;
    
    for i=1:size_proba(1)
        prob = probas(i,:);
        %display(prob);
        
        realClass = floor((i-1)/nbColsTest);
        %display(realClass);
        
        [~,indice_max] = max(prob);
        detectedClass = indice_max -1;
        %display(detectedClass);
        
         if(realClass == detectedClass)
            nbCorrect = nbCorrect + 1;
        end
    end
    ratio = nbCorrect * 100 / (nbColsTest * nbLinesTest);
    display(ratio);
    
end

