function SI = SilhouetteIndex(X, U)

n = size(X,1);

for i=1:n    
    x = X(i,:); %pegara o dado i no conjunto de dados
    group = find(U(:,i)); %encontrar o centroide pertencente do dado i
    M = U; %faz uma copia da matriz U
    M(group,i)=0; %o dado i nao pertence aquele grupo mais, previamente
    datas = find(M(group,:)); %encontra os dados do grupo, aos quais o dado i pertencia
    
    len = size(datas, 2); %pega o tamanho do vetor de datas
    Dxy = [];   %cria um vetor de distancias entre x e y 
    for j=1:len
        y = X(datas(j),:); %pega os atributos dos dados pertencentes ao grupo de i
        Dxy(j) = norm(x-y); %calcula as distancias do dado i para os outros membros
    end    
   a(i) = sum(Dxy)/(len); %calcula a media de distancia 
end


for k=1:n % para cada dado
  x = X(k,:);
  groups = find(not(U(:,k))); % encontra os grupos ao qual x nao pertence
  len = size(groups,1);

  for i=1:len % para cada grupo
    points = find(U(groups(i), :)); % obtem os indices dos dados
    p = size(points,2);
    Dxy = [];
    for j=1:p % para cada dado do grupo
      y = X(points(j),:);
      Dxy(j) = norm(x-y); % calcula distancia
    end
    b(k,i) = sum(Dxy) / p; % obtem distancia media do dado x a cada y do grupo
  end
end

b = min(b'); % obtem distancia media minima para cada dado k

SI = b-a./max(a,b);
SI = mean(SI);

end






