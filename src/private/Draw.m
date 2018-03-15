% =============================================
% Representacao grafica do agrupamento
% Recebe a matriz de dados e os prototipos
% Funciona apenas para dados em duas dimensoes
% =============================================
function Draw(X, C)
  plot(X(:,1), X(:,2), 'o', C(:,1), C(:,2), 'r+', 'markersize', 14);
end