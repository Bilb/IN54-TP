function [ coord ] = buildCoordByLinesCols( lines, cols )
%buildCoordByLinesCols Transforme les  listes d'indices de lignes et
%colonnes en un tableau contenant les coordonées du coin supérieur gauche
%et inférieur droit sur une même ligne pour chaque chiffre.

    size_l = size(lines);
    size_c = size(cols);

    coord = zeros(size_l(2)/4,4);

    for k = 1:(size_c(2)/2)
        % On détermine les coordonnées des 2 coins qui nous intéressent
        x_haut_gauche = cols(1,k*2-1);
        y_haut_gauche = lines(1,k*2-1);
        x_bas_droit = cols(1,k*2);
        y_bas_droit = lines(1,k*2);

        coord(k,:) = [x_haut_gauche, y_haut_gauche, x_bas_droit, y_bas_droit];
       
    end
end

