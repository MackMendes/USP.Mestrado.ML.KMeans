function InfoBasic(n, m, K, d, runInStep, timeSteps, handles)

    if(runInStep == 1)
      %INFORMACOES BASICAS
      stgDis = '';
      if(d == 1)
          stgDis = sprintf('Distancia: Manhattan');
      else
          stgDis = sprintf('Distancia: Euclideana');
      end
      
      handles.lblInfoSteps.String = strvcat('### INFORMACOES DO AGRUPAMENTO ###', ' ', 'Algoritmo: CMEANS', ...
          'Dataset: Dunn', sprintf('Instancias: %d', n), sprintf('Atributos: %d', m), ...
          sprintf('Grupos (K): %d', K));
      
      pause(timeSteps);
    end
end