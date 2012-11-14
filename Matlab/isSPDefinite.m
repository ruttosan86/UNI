function isSPDefinite(matrice)
% Controlla che la matrice in ingresso sia semi/definita positiva
%
% Input
% matrice :matrice da controllare

%accertiamoci che la matrice sia quadrata
dims=size(matrice);

if dims(1)==dims(2)

%per la verifica della propriet�  sfruttiamo il legame con gli autovalori

%calcoliamo gli autovalori della matrice
lambda=eig(matrice);

if any(lambda<0)
%se anche un solo autovalore � negativo la matrice non � n� DP np
%SDP
disp 'matrice non semidefinita positiva'
elseif all(lambda>0)
%se tutti gli autovalori sono positivi stretti la matrice � definita
%positiva
disp 'matrice definita positiva'
else
%se tutti gli autovalori sono >=0 la matrice � semidefinita
%positiva
disp 'matrice semidefinita positiva'
end

end
end
