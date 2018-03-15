% ================================================
% Calcula custo do agrupamento com base na
% matriz D de distancias, matriz U de pertinencias
% e grau f de fuzzificacao
% ================================================
function J = Cost(U, D, f)
[k, n] = size(U); % Obtem dimensoes da matriz de pertinencias
J = 0;

for i=1:k
    for j=1:n
        %Faz a soma das distancias ponderadas pelo grau de pertinencia
        J = J + U(i,j)^f * D(i,j)^2;
    end    
end

end