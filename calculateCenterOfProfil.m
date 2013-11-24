function [ centers ] = calculateCenterOfProfils(profils, nbNumberPerLine)
%calculateCenterOfProfil Retourne le centre (vecteur) du
%profil du chiffres passé en paramètre.

size_p = size(profils);
nbClasses = size_p(1)/nbNumberPerLine;
nbLinePerProfil = size_p(2);
%display(size_p);


centers = zeros(nbClasses, nbLinePerProfil);
%size_centers = size(centers);
%display(size_centers);

for i=1:nbClasses
   centers(i,:) = calculateProfilOfClass(profils( ((i-1)*nbNumberPerLine+1):(i * nbNumberPerLine) ,:));
end





end