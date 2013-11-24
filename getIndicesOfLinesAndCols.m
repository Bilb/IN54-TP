function [ indicesLinesCorrect, indicesCols ] = getIndicesOfLinesAndCols( BI, nbLines, nbCols )
%getIndicesOfLinesAndCols Retourne les indices des lignes et colonnes de
%chiffres de l'image BI
% 

% récupération d'une première approximation de la ligne des chiffres.

% Approximation, car on prends la ligne du pixel le plus bas sur la ligne,
% donc certains chiffres auront plus de blanc autour que d'autres.
% On corrigera cela en réalisant une deuxième passe.
indicesLines = getIndicesLines(BI,nbLines, 0);

%récupérations des différentes colonnes des chiffres, par lignes
indicesCols=  [];
for k=1:nbLines
    % On extrait l'image associé à la ligne des chiffres en question
    subImage = BI(indicesLines(1,k*2 -1): indicesLines(1,k*2),:);
    % Et on appelle notre méthode sur cette ligne.
    indicesCols = [indicesCols, [getIndicesCols(subImage',nbCols)] ];
end

% Récupération plus précise de l'indice de la ligne du chiffre. Nous
% pouvons le faire maintenant car cette fois, la largeur du chiffre est
% bornée (cf étape précédente).
indicesLinesCorrect=  [];

for k=1:(nbLines*nbCols)
    lines = indicesLines(1, 2*floor(((k-1)/nbCols)) + 1 ):indicesLines(1,2*floor(((k-1)/nbCols)) + 2);
    cols = indicesCols(1,k*2 -1): indicesCols(1,k*2);
    
    subImage = BI(lines, cols);
    lineOffset = indicesLines(1, 2*floor(((k-1)/nbCols)) + 1 );
    indicesLinesCorrect = [indicesLinesCorrect, [getIndicesLines(subImage,1, lineOffset)]];
end


end

