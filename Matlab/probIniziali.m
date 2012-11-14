function [ P ] = probIniziali( S )
nPagine = 20;
epsilon = 0.0001;
P = zeros(1,nPagine);
nRighe = length(S(:,1));
for i=1:nRighe
   if(S(i,1)~=0) 
    P(S(i,1))= P(S(i,1)) + 1;
   end
end
P = P / nRighe;
for c=1:nPagine
    if(P(c)==0)
        P(c) = epsilon;
    end
end
P = P / sum(P);
end

