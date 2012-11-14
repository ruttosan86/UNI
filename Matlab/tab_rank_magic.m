function [ Y ] = tab_rank_magic( n )
%tab_rank_magic rango delle matrici magiche
Y=zeros(n,2);
for k=1:n
    Y(k,1)=k;   
    Y(k,2)=rank(magic(k));
end

end

