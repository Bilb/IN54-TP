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



% ---------------- PARAMETRES DES PROFILS ---------------- %
%for nbLinePerProfil=1:1
%    display(nbLinePerProfil);
%    analyzeNumbersByProfils(IMAGE_FILENAME_LEARN, ...
%        NB_LIGNES_CHIFFRES_IMAGE_LEARN,NB_COLS_CHIFFRES_IMAGE_LEARN, ...
%        nbLinePerProfil, COORD_SAVE_FILENAME, IMAGE_FILENAME_TEST, ...
%        NB_LIGNES_CHIFFRES_IMAGE_TEST, NB_COLS_CHIFFRES_IMAGE_TEST);
%end

%BW = openImage(IMAGE_FILENAME_LEARN);

%coord = [163, 62, 220, 114];
%coord = [2004, 1058, 2052, 1168];
%result = analyzePerArea(BW, coord ,10, 4);
%display(result);


j=0;
for zones=1:8
        for nbK=1:15
            probs = calculateProbsKPPV( IMAGE_FILENAME_LEARN, IMAGE_FILENAME_TEST, ...
                zones, zones, NB_LIGNES_CHIFFRES_IMAGE_LEARN, NB_COLS_CHIFFRES_IMAGE_LEARN, ...
                NB_LIGNES_CHIFFRES_IMAGE_TEST, NB_COLS_CHIFFRES_IMAGE_TEST, ...
                DENSITE_SAVE_FILENAME, PROBA_DENSITE_SAVE_FILENAME,nbK)



            sizeP = size(probs);
            count =0;
            for i=1:sizeP(1)
               [val, idx] = max(probs(i,:));
               if idx==(floor(i/NB_COLS_CHIFFRES_IMAGE_TEST) + 1)
                   count = count + 1;
               end
            end

            j = j +1;
            display(j);
            percent = 100*count/sizeP(1);
            display(percent);
        end
end

% checker si résultat ok :X
% http://fr.wikipedia.org/wiki/Recherche_des_plus_proches_voisins
% save file probas
% relire tout les commentaires + en ajouter






