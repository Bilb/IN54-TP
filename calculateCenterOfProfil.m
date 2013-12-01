function [ centers ] = calculateCenterOfProfil(profils, nbNumberPerLine)
%calculateCenterOfProfil Calculs les profils médians, par classes de 
% nbNumberPerLine profils en provenance de profils
% profils listes des profils des chiffres 
% nbNumberPerLine nombre de chiffres par lignes dans l'image en question

size_p = size(profils);
% Nombre de classe
nbClasses = size_p(1)/nbNumberPerLine;

% On détermine le nombre de ligne par profil
nbLinePerProfil = size_p(2);

% Pré initialisation
centers = zeros(nbClasses, nbLinePerProfil);

% Pour chaque classe, on calcule le centre de la classe et on l'ajoute.
for i=1:nbClasses
   centers(i,:) = calculateProfilOfClass(profils( ((i-1)*nbNumberPerLine+1):(i * nbNumberPerLine) ,:));
end





end