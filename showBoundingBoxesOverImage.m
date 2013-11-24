function [ ] = showBoundingBoxesOverImage( BW, lines, cols )
%showBoundingBoxesOverImage Affiche l'image BW et y superpose les
%boundingboxes des chiffres trouvés

figure(3);
imshow(BW);
hold on;

size_c = size(cols);

for k = 1:(size_c(2)/2)
    x = cols(1,k*2-1);
    y = lines(1,k*2-1);
    w = cols(1,k*2)-x;
    h = lines(1,k*2)-y;
    rectangle('position',[x,y,w,h],'Edgecolor','g')
end

hold off;

end

