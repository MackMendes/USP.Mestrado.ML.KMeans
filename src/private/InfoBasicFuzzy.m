function InfoBasicFuzzy(n, m, K, f, d, runInStep, timeSteps, handles)

    if(runInStep == 1)
      %INFORMACOES BASICAS
      stgDis = '';
      if(d == 1)
          stgDis = sprintf('Distancia: Manhattan');
      else
          stgDis = sprintf('Distancia: Euclideana');
      end
      
      handles.lblInfoSteps.String = strvcat('### INFORMACOES DO AGRUPAMENTO ###', ' ', 'Algoritmo: CMEANS - FUZZY', ...
          'Dataset: Dunn', sprintf('Instancias: %d', n), sprintf('Atributos: %d', m), sprintf('Fator de Fazzificação: %d', f), ...
          sprintf('Grupos (K): %d', K));
      
      pause(timeSteps);
    end
end