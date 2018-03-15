function InfoSilhouette(info, SI, runInStep, timeSteps, handles)
    %INFORMACOES DOS SILHOUETTE
     if(runInStep == 1)    
      handles.lblInfoSteps.String = info;
      pause(timeSteps);
     end
end