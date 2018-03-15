function InfoSimple(info, runInStep, timeSteps, handles)
    %INFORMACOES SIMPLES PARA MOSTRAR
     if(runInStep == 1)    
      handles.lblInfoSteps.String = info;
      pause(timeSteps);
     end
end