function [ ] = saveToFile(filename,data, message )
%saveToFile Sauve les données data dans le fichier filename, sous forme de
%text.
% message : message  à affiché au succès

save(filename, 'data', '-ascii');
display(message);
    
end

