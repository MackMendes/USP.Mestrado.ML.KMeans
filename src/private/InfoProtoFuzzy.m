function InfoProtoFuzzy(info, C, X, U, runInStep, timeSteps, handles)
     [n, m] = size(U);
     groups='';
     %INFORMACOES DOS PROTOTIPOS
     if(runInStep == 1)    
      handles.lblInfoSteps.String = info;      
      Draw(X, C);
      pause(timeSteps);
     end
end