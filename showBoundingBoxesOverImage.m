function [ ] = showBoundingBoxesOverImage( BW, lines, cols )
%showBoundingBoxesOverImage Affiche l'image BW et y superpose des
% rectanges correspondant aux boundingboxes représentées par lines et cols

% On créé une fenêtre
figure(); %3?
% On y affiche l'image
imshow(BW);
% Garde l'image actuelle afin d'y ajouter les rectangles
hold on;

size_c = size(cols);

% Un rectangle possède deux colonnes, on itère donc jusqu'à size(cols)/2
for k = 1:(size_c(2)/2)
    % l'affichage du rectangle nécessite x et y du coin au gauche et la
    % hauteur et largeur du rectangle. On les calcul donc.
    x = cols(1,k*2-1); 
    y = lines(1,k*2-1);
    w = cols(1,k*2)-x;
    h = lines(1,k*2)-y;
    % On ajoute les rectangles  à l'image
    rectangle('position',[x,y,w,h],'Edgecolor','g')
end

hold off;

end

