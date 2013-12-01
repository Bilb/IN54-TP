function [ result ] = combineProbasByAdd( probasFilename1, ...
                probasFilename2)
%combineProbasByAdd combine les résultats des deux classifieurs en les
%additionnant.
% probasFilename1 nom du fichier des données du classifieur 1
% probasFilename2 nom du fichier des données du classifieur 2

% On charge les données
probs1 = importdata(probasFilename1);
probs2 = importdata(probasFilename2);


sizeP1 = size(probs1);
% On commence par vérifié que les deux ont la même taille
if( isequal(sizeP1, size(probs2)))
    result = zeros(sizeP1(1),sizeP1(2));
    % Pour chaque ligne et colonnes, on additionne
    for i=1:sizeP1(1)
       for j=1:sizeP1(2)
          result(i,j) = probs1(i,j) + probs2(i,j);
       end
    end
else
    display('Les deux fichiers ne contiennent pas le même nombre d éléments.');
    result = zeros();

end
