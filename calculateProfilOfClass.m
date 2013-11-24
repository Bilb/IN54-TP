function [ centersOfClass ] = calculateProfilOfClass(profilsOfClass)
%calculateProfilOfClass Retourne le vecteur moyen du profil de la classe en
%paramètres

    size_p = size(profilsOfClass);
    %display(profilsOfClass);
    
    % centersOfClass va contenir la moyenne des différents valeur du profil
    % de cette classe.
    centersOfClass = zeros(1,size_p(2));

    for i=1:size_p(2)
        centersOfClass(1,i) = mean(profilsOfClass(:,i));
    end
    
    

end
