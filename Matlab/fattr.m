function [ f ] = fattr( n )
%fattr fattoriale di n calcolato in modo ricorsivo
if n<=1
    f=1;
else
    f=n*fattr(n-1);
end

end

