%Create a random objective function composed of the model reactions; each
%reaction is assigned a random probability for being included in the
%objective function

function ObjectiveFunction = getRandomObjectiveFunctionAndThreshold(nRxns)

rng('shuffle');

threshold=rand;
ObjectiveFunction=zeros(nRxns,1);

for i=1:nRxns
    if (rand()>=threshold)
        ObjectiveFunction(i)=rand();
    end
    
end

f=find(ObjectiveFunction>0);
while (isempty(f))
    ObjectiveFunction=getRandomObjectiveFunctionAndThreshold(nRxns);
    f=find(ObjectiveFunction>0);
end