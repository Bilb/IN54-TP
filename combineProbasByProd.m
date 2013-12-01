function [ result ] = combineProbasByProd( probasFilename1, ...
                probasFilename2)
%combineProbasByProd combine les résultats des deux classifieurs en les
%multipliant.
% probasFilename1 nom du fichier des données du classifieur 1
% probasFilename2 nom du fichier des données du classifieur 2 

probs1 = importdata(probasFilename1);
probs2 = importdata(probasFilename2);


 sizeP1 = size(probs1);
if( isequal(sizeP1, size(probs2)))
    %display('Même taille de données. Calcul des probas par produits');
    result = zeros(sizeP1(1),sizeP1(2));
    for i=1:sizeP1(1)
       for j=1:sizeP1(2)
          result(i,j) = probs1(i,j) * probs2(i,j);
       end
    end
else
    display('Les deux fichiers ne contiennent pas le même nombre d éléments.');
    result = zeros();
end
