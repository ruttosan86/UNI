fid = apriFile();
[fileLetto, righe, colonne] = leggiFile(fid);
scelta=-1;
scelte = zeros(1);
id = 1;
selected =0;
while (scelta<1 || scelta> colonne +1 )
scelta = input('1 var1 \n2 var2 \n3 var3 \n4 var4 \n var5\n6 basta.\n Scegli: ');
if(scelta<1 || scelta> colonne +1)
    fprintf('scegli bene maledetto!');
else if(1<=scelta<=colonne)
    scelte(id)=scelta;
    selected = 1;
    id = id + 1;
    else
        if(selected==1)
            break;
        end
    end
end

end
scelte