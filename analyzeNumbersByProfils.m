function [ probas, ratio ] = analyzeNumbersByProfils(filenameLearn, ...
nbLinesLearn,nbColsLearn, ...
nbLinePerProfil, filenameSaveCoord, filenameSaveMediumProfils, filenameTest, ...
nbLinesTest, nbColsTest, probaFilenameSave )
%analyzeNumbersByProfils Analyse les chiffres par la méthode des profils.
% filenameLearn nom du fichier contenant l'image d'apprentissage
% nbLinesLearn nombre de lignes de chiffres dans l'image d'apprentissage
% nbColsLearn nombre de cols de chiffres dans l'image d'apprentissage
% nbLinePerProfil nombre de lignes  par profil
% filenameSaveCoord nom du fichier de sauvegarde des coordonnées des 
%                                           boundingbox
% filenameSaveMediumProfils nom du fichier de sauvegarde des profils
%                                           médians
% filenameTest nom du fichier contenant l'image de test
% nbLinesTest nombre de lignes de chiffres dans l'image de test
% nbColsTest nombre de lignes de chiffres dans l'image de test
% probaFilenameSave nom du fichier de sauvegarde du résultat (proba)

    % On récupère les profils médians de l'image d'apprentissage
    profilsMedium = getMediumProfilsOfImage(filenameLearn, ...
        nbLinesLearn, nbColsLearn, ...
        nbLinePerProfil, filenameSaveCoord);
    
    
    % -- sauve les profils médians dans le fichier associé
    saveToFile(filenameSaveMediumProfils, profilsMedium, 'Profils médians sauvés');
    
    % On analyse proprement dit l'image de test vis à vis de l'image
    % d'apprentissage
    probas = analyzeTestImageByProfil( filenameTest,  ...
        nbLinesTest, nbColsTest, nbLinePerProfil, profilsMedium, ...
        probaFilenameSave);

    size_proba = size(probas);
    
    % Nombre de bonne classifications
    nbCorrect = 0;
    
    for i=1:size_proba(1)
        % On extrait la ligne courante
        prob = probas(i,:);
        
        % La classe réelle est dans notre cas, le numéro de la ligne du
        % chiffre en question. On la trouve via :
        realClass = floor((i-1)/nbColsTest);
        
        % récupération du max des probas de la ligne courante
        [~,indice_max] = max(prob);
        % Comme on commence nos classe à 0 (0 est un chiffre), il faut
        % soustraire 1
        detectedClass = indice_max -1;
        
         if(realClass == detectedClass)
            nbCorrect = nbCorrect + 1;
        end
    end
    % le ratio de bonne classification se calcul de la façon suivante :
    ratio = nbCorrect * 100 / (nbColsTest * nbLinesTest);
    
    
    saveToFile(probaFilenameSave, probas, 'Données de classification par profils sauvées');
end

