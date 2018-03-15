% =============================================
% Dadas as matrizes C e X, retorna a matriz D
% de distancias de cada elemento x a cada 
% prototipo c.
% =============================================
function D = DistanceMatrix(C, X, d)
  k = size(C, 1);
  n = size(X, 1);
  
  for i=1:k
    c = C(i,:);
    for j=1:n
      x = X(j,:);
      D(i,j) = norm(c-x, d);
    end
  end
end