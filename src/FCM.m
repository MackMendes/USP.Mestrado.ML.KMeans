function FCM(k, d, f, epsilon, runInStep, timeSteps, handles)
    load ../datasets/test/dunn;
    [U, C, t] = funcFCM(dunn, k, d, f, epsilon, runInStep, timeSteps, handles);   
end

% ====================================
% Fuzzy C-Means (FCM)
% X = dados; K = numero de grupos;
% f = fator de fuzzificacao; d = tipo
% de distancia;
% E.g:
% [U, C, t] = fkmeans(dunn, 3, 2, 2, 1e-6);
% ====================================
function [U, C, t] = funcFCM(X, K, d, f, epsilon, runInStep, timeSteps, handles)
  subplot(1,1,1);
  % INICIALIZACAO
  [n, m] = size(X); % Obtem dimensoes dos dados de entrada
  
  InfoBasicFuzzy(n, m, K, f, d, runInStep, timeSteps, handles);
    
  % PROTOTIPOS
  C = [];
  
  for k = 1:K
    for i = 1:m  % Para cada atributo j do prototipo i
      lb = min(X(:,i));  % menor valor do atributo j em X
      ub = max(X(:,i));  % maior valor do atributo j em X
        
      C(k, i) = RandBetween(lb,ub);
    end
  end
  
  InfoProtoFuzzy('Os Prototipos sao inicializados aleatoriamente.', C, X, [], runInStep, timeSteps, handles);
  
  J = [];
  t = 0;
  delta = 1; 
  while delta > epsilon
    t = t + 1;
    [D, U] = UpdateUf(X, C, K, n, f, d);
    oldC = C;
    C = UpdateCf(U, X, f, K, n);
    
    InfoProtoFuzzy(sprintf('Prototipos na iteracao %d', t), C, X, U, runInStep, (timeSteps/2), handles);
    
    D = DistanceMatrix(C, X, d);
    J =  Cost(U, D, f);
    %disp(sprintf('Custo do agrupamento na iteraçao %d: %1.2f', t, J));
    delta = abs(C - oldC);
    delta = sum(sum(delta));
  end
  
  InfoSimple('Convergiu!', runInStep, 5, handles);
  Draw(X, C);

  %hold on;
  
end

function [D, U] = UpdateUf(X, C, K, n, f, d)
  % Calculo da matriz D de distancias
  D = DistanceMatrix(C, X, d);
  
  % Atualizaçao de U
  for i=1:K
    for j=1:n
      if D(i,j) == 0 % Excecao 1: O prototipo i sobrepoe-se ao dado j?
        U(i,j) = 1;
      elseif sum(D(:,j) == 0) > 0 % Excecao 2: Ha prototipo l sobreposto ao dado j, l != i
        U(i,j) = 0;
      else
        U(i,j) = 1 / (sum((D(:, j) ./ D(i,j)).^ (1 / (1 - f))));
      end
    end
  end
end

function C = UpdateCf(U, X, f, K, n)
  for i=1:K
    soma = 0;
    for j=1:n
      soma = soma + (U(i,j) ^ f) * X(j,:);
    end
    C(i, :) = soma / (sum(U(i,:) .^ f));
  end
end