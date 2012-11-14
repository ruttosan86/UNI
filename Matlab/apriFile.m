function [ fid ] = apriFile(  )
%APRIFILE chiede via GUI di aprire un file di testo
[file,path] = uigetfile('*.txt', 'Scegli il file da aprire');
pathCompl = [path, '/', file];
fid = fopen(pathCompl);
end

