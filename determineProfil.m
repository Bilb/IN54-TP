function [ profil ] = determineProfil( BW, box, nbLines )
%determineProfil Retourne le profil du chiffre de la sous image de BW
%basé sur les coordonnées de la box box.
% BW image binaire source
% box coordonnées de la boite englobante à prendre en compte
% nbLines est le nombre de lignes à prendre en compte pour le calcul du
% profil. 

% extraction de la sous image
subImage = BW(box(2):box(4),box(1):box(3));

% profil complet de ce chiffre. (nbLines pour le gauche et nbLines pour le droit)
profil = zeros(nbLines*2,1);

%taille de l'image
size_i = size(subImage);

    %pour chaque lignes virtuelle du profil, chercher le premier pixel blanc
    for i=1:nbLines
        % nbLines + 1 afin d'avoir une répartition homogène des lignes sur le
        % chiffre, et pas en avoir une sur la dernière ligne de pixels du
        % chiffres.
        line = round(size_i(1)*i/(nbLines+1));

        firstWhitePixelIndiceLeft = -1;
        firstWhitePixelIndiceRight = -1;
        indice=1;

        while((firstWhitePixelIndiceLeft == -1 || firstWhitePixelIndiceRight == -1) && indice < size_i(2)+1)
            % On cherche depuis le coté gauche le premier pixel blanc
            if(subImage(line,indice) > 0 && firstWhitePixelIndiceLeft==-1 )
                firstWhitePixelIndiceLeft = indice;
            end 
            
            % On cherche depuis le coté droit le premier pixel blanc
            if(subImage(line, size_i(2)+1 - indice) > 0 && firstWhitePixelIndiceRight == -1)
                firstWhitePixelIndiceRight = indice;
            end 
            indice = indice + 1;
        end
        % On le normalise par rapport à la hauteur du chiffre
        profil(2*i-1) = firstWhitePixelIndiceLeft*100/size_i(1);
        profil(2*i) = firstWhitePixelIndiceRight*100/size_i(1);
    end
    
end

