function InfoProto(info, C, X, U, runInStep, timeSteps, handles)
     [n, m] = size(U);
     groups='';
     %INFORMACOES DOS PROTOTIPOS
     if(runInStep == 1)    
      handles.lblInfoSteps.String = info;
      for i = 1:n
          d = sum(U(i,:));
          groups = strvcat(groups, sprintf('Grupo %d: %d dados', i,d)); 
      end
      handles.lblInfoSteps.String = strvcat(info, groups);
      
      Draw(X, C);
      pause(timeSteps);
     end
end