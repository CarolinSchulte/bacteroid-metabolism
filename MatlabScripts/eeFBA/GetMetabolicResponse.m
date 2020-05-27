
function [MetabolicResponse] = GetMetabolicResponse(model,flux2change,fluxValues,bound2change)

MetabolicResponse=[];

originalValueU=model.ub(flux2change);
originalValueL=model.lb(flux2change);

for g=1:length(fluxValues)
    
    i=fluxValues(g); 

    if strcmp(bound2change,'u')
        model= changeRxnBounds(model,flux2change,i,'u'); %setto l'upper bound del flusso (e.g model.ub(glucose_uptake_id)=valore a cui vogliamo settarlo g)
    elseif strcmp(bound2change,'l')
        model= changeRxnBounds(model,flux2change,i,'l');
    elseif strcmp(bound2change,'b')
        model= changeRxnBounds(model,flux2change,i,'b');
    else
        error('bound type not correctly defined')
    end

    solution=optimizeCbModel(model,'max'); 
  
    if (abs(solution.f)>=0)     
        MetabolicResponse=[MetabolicResponse solution.x];

    end 
end
               
     model= changeRxnBounds(model,flux2change,originalValueU(1),'u');
     model= changeRxnBounds(model,flux2change,originalValueL(1),'l'); 
end


         
         


    
 

