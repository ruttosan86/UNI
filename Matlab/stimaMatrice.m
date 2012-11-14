function [ M ] = stimaMatrice( S )

nPagine  = 20;
M = zeros(nPagine, nPagine);
nRighe = length(S(:,1));
nColonne = length(S(1,:));
i=1;
j=1;
epsilon=0.0001;
while(i<=nRighe)
    while(j<nColonne && S(i,j+1)~=0)
            M(S(i,j),S(i,j+1)) = M(S(i,j),S(i,j+1)) + 1;
            j = j+1;
    end
    i = i+1;
    j=1;
end
M(1,1)
for i=1:nPagine
    if(sum(M(i,:)) ~= 0)
        M(i,:) = M(i,:)/sum(M(i,:));

    end
end

for i=1:nPagine
    for j=1:nPagine
        if(M(i,j)==0)
            M(i,j)=epsilon;
        end
    end
end

for i=1:nPagine
    M(i,:) = M(i,:)/sum(M(i,:));
end
end

