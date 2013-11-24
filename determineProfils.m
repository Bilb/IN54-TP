function [ profils ] = determineProfils( BW, coord, nbLinesPerProfil )
%determineProfils Determine the profils of each number found in BW with the
%specified boudingBox

size_c = size(coord);
profils = zeros(size_c(1),nbLinesPerProfil*2);





for k=1:(size_c(1))
    % boîte englobante de ce nombre
    box = coord(k,:);
    
    profil = determineProfil( BW, box, nbLinesPerProfil );
    
    profils(k,:) = profil;
end


%display(profils);


end

