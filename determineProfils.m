function [ profils ] = determineProfils( BW, coord, nbLinesPerProfil )
%determineProfils Determine les profils pour chaque boudingboxes de coord
% BW image binaire source
% coord coordonnées des chifres dans l'image
% nbLinesPerProfil nombre de lignes par profil

size_c = size(coord);
profils = zeros(size_c(1),nbLinesPerProfil*2);

for k=1:(size_c(1))
    % boîte englobante de ce nombre
    box = coord(k,:);
    
    profil = determineProfil( BW, box, nbLinesPerProfil );
    
    profils(k,:) = profil;
end

end

