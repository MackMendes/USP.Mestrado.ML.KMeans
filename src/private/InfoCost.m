function InfoCost(info, J, runInStep, timeSteps, handles)
    %INFORMACOES DE CUSTO
     if(runInStep == 1)    
      handles.lblInfoSteps.String = info;
      %plot(J);
      pause(timeSteps);
     end
end