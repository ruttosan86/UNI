function [ fileLetto, numRighe, numColonne ] = leggiFile( fid )
%LEGGIFILE legge il file 'fid'. deve essere di testo.
numRighe = fscanf(fid, '%d',1);
numColonne =  fscanf(fid, '%d',1);
fileLetto = cell(numRighe,numColonne);
for i=1:numRighe
    fileLetto{i,1}=fscanf(fid, '%f',1);
    fileLetto{i,2}=fscanf(fid, '%f',1);
    fileLetto{i,3}=fscanf(fid, '%f',1);
    fileLetto{i,4}=fscanf(fid, '%s',1);
    fileLetto{i,5}=fscanf(fid,'%d',1);
end

end

