function [MetabolicResponses]= getMetabolicResponses(model,flux2change,fluxValues,bound2change,ObjectiveFunctions,MetabolicResponses)

for i=size(MetabolicResponses,1)+1:size(ObjectiveFunctions,2)
       disp(i) 
       model.c=ObjectiveFunctions(:,i);
       MetabolicResponse = GetMetabolicResponse(model,flux2change,fluxValues,bound2change);
       MetabolicResponses(i,:,:)=MetabolicResponse; 
end