function Cmeans(k, d, epsilon, runInStep, timeSteps, handles)
    % load ../datasets/test/dunn;
    % [U, C, t] = funcCmeans(dunn, k, d, epsilon, runInStep, timeSteps, handles);
    load iris.dat 
    [U, C, t] = funcCmeans(iris(:,3:4), k, d, epsilon, runInStep, timeSteps, handles);    
end

% ========================================
% Algoritmo de K-Means Classico  
% Chamada: 
% 1: Carrega os dados que estiver na pasta /datasets/test ou /datasets/s-sets. 
%     Por exemplo Dunn: Executa: load dunn.data 
%                                load s1
% 2: Executa: [U, C, t] = Cmeans(dunn, 3, 2, 1e-6)
%   Outro teste: [U, C, t] = Cmeans(s1, 15, 2, 1e-6)
% =========================================
function [U, C, t] = funcCmeans(X, K, d, epsilon, runInStep, timeSteps, handles)
    subplot(1,1,1);
  % INICIALIZACAO
  [n, m] = size(X); % Obtem dimensoes dos dados de entrada
  
  InfoBasic(n, m, K, d, runInStep, timeSteps, handles);
  
  % PROTOTIPOS
  C = [];

  for k = 1:K
    for i = 1:m  % Para cada atributo j do prototipo i
      lb = min(X(:,i));  % menor valor do atributo j em X
      ub = max(X(:,i));  % maior valor do atributo j em X
       
      C(k, i) = RandBetween(lb,ub);
    end
  end
  
  InfoProto('Os Prototipos sao inicializados aleatoriamente.', C, X, [], runInStep, timeSteps, handles);
      
  t = 0;
  delta = 1;
  J = [];
  SI = [];
  while delta > epsilon
    t = t + 1;
    U = UpdateU(X, K, n, C, d);    
    oldC = C;
    C = UpdateC(U, X, K);
    
    InfoProto(sprintf('Prototipos na iteracao %d', t), C, X, U, runInStep, (timeSteps/2), handles);
    
    D = DistanceMatrix(C, X, d);
    J = [J; Cost(U, D, 1)];
    
    %InfoCost(sprintf('Custo do agrupamento: %1.2f', J), J, runInStep, timeSteps, handles);
    
    SI = [SI; SilhouetteIndex(X, U)];
    
    %InfoSilhouette(sprintf('Silhouette: %1.2f', SI), SI, runInStep, timeSteps, handles);
    %InfoSimple(strvcat(sprintf('Custo do agrupamento: %1.2f', J), sprintf('Silhouette: %1.2f', SI)), runInStep, (timeSteps/2), handles);
    
    delta = abs(C - oldC);
    delta = sum(sum(delta));
    
  end
  
  Restriction1(U,n, runInStep, handles);
  Restriction2(U,K, runInStep, handles);
  
  %Draw(X, C);
  InfoSimple('Convergiu!', runInStep, 5, handles);
  subplot(2,1,1);
  Draw(X, C);
  subplot(2,1,2);
  plot(log(J));
  hold on;
  plot(SI, 'r-');
  xlabel('Iteracoes');
  legend('Custo do agrupamento', 'Silhouette Index');
  hold off;
end

function U = UpdateU(X, K, n, C, d)
  
  % MATRIZ DE PERTINENCIA
  U = zeros(K, n);  % Inicializa matriz U com zeros
  
  for j = 1:n % Para cada instancia
    x = X(j,:);
    dist = [];  % Inicializa vetor-coluna de distancias.
    for k = 1:K % Para cada prototipo
      c = C(k,:);    
      dist = [dist;norm(c-x, d)];
    end
    p = find(dist == min(dist));
    U(p,j) = 1;
  end
  
end

function C = UpdateC(U, X, K)
% ATUALIZACAO DOS PROTOTIPOS
  C = U * X; % Soma todas as instancias pertencentes aos prototipos
  for k = 1:K
    % Divide cada atributo de cada prototipo pelo numero de instancias pertencentes a ele
    C(k,:) = C(k,:) ./ sum(U(k,:));
  end

end

function Restriction1(U, n, runInStep, handles)

for i=1:n 
    soma = sum(U(:,i)); %acessa todas as linhas da coluna i e faz o somatorio
    %Se a soma for diferente de 1, isto quer dizer que o dado i pode estar
    %em nenhum grupo ou em varios grupos, nao em apenas um grupo, o que
    %esta errado!
    if soma ~= 1 
        str = sprintf('Restricao 1 violada: O dado %d esta em %d grupos', i, soma);
        InfoSimple(str, runInStep, 5, handles);
    end
end
end

function Restriction2(U, K, runInStep, handles)

for i=1:K
    soma = sum(U(i,:)); %acessa todas as colunas da linha i e faz o somatorio
    %se a soma = 0, o prototipo nao possui dados, o que nao esta errado,
    %porem nao eh o comportamento esperado.
    if soma == 0 
        str = sprintf('Restricao 2 violada: O prototipo %d nao "possui" dados', i);
        InfoSimple(str, runInStep, 5, handles);
    end
end
end