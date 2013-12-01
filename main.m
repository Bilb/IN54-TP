% ------------- CONSTANTES ------------- %

% ---------------- IMAGE DE FORMATION ---------------- %
% nom du fichier contenant l'image à étudier
% attention à régler les paramètres suivant en conséquence !
IMAGE_FILENAME_LEARN = 'app.tif'; 

% nom du fichier où il faut sauver les données extraites de l'image
% concernant les coordonées des chiffres.
COORD_SAVE_FILENAME = 'coordonees_chiffres.txt'; 

% nom du fichier où il faut sauver les données des profils médians des 
% chiffres analysés
PROFILS_SAVE_FILENAME = 'profils_chiffres.txt'; 

% nom du fichier où il faut sauver les données du classifieur densité
% elle sont sauvées en applatissant les deux dernières dimensions en une
% seule
DENSITE_SAVE_FILENAME = 'densite_chiffres.txt'; 


% nom du fichier où il faut sauver les données des probas de l'analyse des
% chiffres par la méthode des profils
PROBA_PROFILS_SAVE_FILENAME = 'proba_profils_chiffres.txt'; 


% nom du fichier où il faut sauver les données des probas de l'analyse des
% chiffres par la méthode des densité
PROBA_DENSITE_SAVE_FILENAME = 'proba_densite_chiffres.txt'; 


% nombre de ligne de chiffres contenu dans cette image
NB_LIGNES_CHIFFRES_IMAGE_LEARN = 10;

% nombre de colones de chiffres contenu dans cette image
NB_COLS_CHIFFRES_IMAGE_LEARN = 20;

% nombre de chiffres contenu dans cette image
NB_CHIFFRES_IMAGE_LEARN = NB_COLS_CHIFFRES_IMAGE_LEARN * NB_LIGNES_CHIFFRES_IMAGE_LEARN;


% ---------------- IMAGE DE TEST ---------------- %
% nom du fichier contenant l'image à tester
% attention à régler les paramètres suivant en conséquence !
IMAGE_FILENAME_TEST = 'test.tif'; 

% nombre de ligne de chiffres contenu dans l'image de test
NB_LIGNES_CHIFFRES_IMAGE_TEST = 10;

% nombre de colones de chiffres contenu dans l'image de test
NB_COLS_CHIFFRES_IMAGE_TEST = 10;

% nombre de chiffres contenu dans l'image de test
NB_CHIFFRES_IMAGE_TEST = NB_COLS_CHIFFRES_IMAGE_TEST * NB_LIGNES_CHIFFRES_IMAGE_TEST;



%------------ début du programme ------------%

nbLinePerProfil=10;
% évalue les probabilités d'appartenances de chacun des chiffre à chacunes
% des classes via les profils, et les sauvent dans PROBA_PROFILS_SAVE_FILENAME
analyzeNumbersByProfils(IMAGE_FILENAME_LEARN, ...
         NB_LIGNES_CHIFFRES_IMAGE_LEARN,NB_COLS_CHIFFRES_IMAGE_LEARN, ...
         nbLinePerProfil, COORD_SAVE_FILENAME, PROFILS_SAVE_FILENAME, IMAGE_FILENAME_TEST, ...
         NB_LIGNES_CHIFFRES_IMAGE_TEST, NB_COLS_CHIFFRES_IMAGE_TEST, ...
         PROBA_PROFILS_SAVE_FILENAME);





nbZones = 5;
nbK=2;
% évalue les probabilités d'appartenances de chacun des chiffre à chacunes
% des classes via densité et KPPV, 
% et les sauvent dans PROBA_DENSITE_SAVE_FILENAME
calculateProbsKPPV( IMAGE_FILENAME_LEARN, IMAGE_FILENAME_TEST, ...
            nbZones, nbZones, NB_LIGNES_CHIFFRES_IMAGE_LEARN, NB_COLS_CHIFFRES_IMAGE_LEARN, ...
            NB_LIGNES_CHIFFRES_IMAGE_TEST, NB_COLS_CHIFFRES_IMAGE_TEST, ...
            DENSITE_SAVE_FILENAME, PROBA_DENSITE_SAVE_FILENAME,nbK);



% Combine les résultats via la méthode de la somme
resultAdd = combineProbasByAdd(PROBA_PROFILS_SAVE_FILENAME, ...
                PROBA_DENSITE_SAVE_FILENAME);


% Combine les résultats via la méthode du produit
resultProd = combineProbasByProd(PROBA_PROFILS_SAVE_FILENAME, ...
                PROBA_DENSITE_SAVE_FILENAME);

% Pour chacuns des résultats ci dessus
for resultNumber=1:2
    if resultNumber==1
        result = resultAdd;
    end
    if resultNumber==2
        result = resultProd;
    end
    sizeRet = size(result);
    nbCorrect = 0;
    for i=1:sizeRet(1)
            prob = result(i,:);
            realClass = floor((i-1)/NB_COLS_CHIFFRES_IMAGE_TEST);

            [~,indice_max] = max(prob);
            detectedClass = indice_max -1;

             if(realClass == detectedClass)
                nbCorrect = nbCorrect + 1;
            end
    end
    ratio = nbCorrect * 100 / (NB_COLS_CHIFFRES_IMAGE_TEST * NB_LIGNES_CHIFFRES_IMAGE_TEST);
    
    if resultNumber==1
        display('Résultats par la somme des probas calculées par chacun des classifieurs :');
    end
    if resultNumber==2
        display('Résultats par produits des probas calculées par chacun des classifieurs :');
    end
    display(ratio);
end
       



