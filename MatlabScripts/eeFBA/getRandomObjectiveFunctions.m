%Create a matrix of random objective functions nRxns*nFunctions

function ObjectiveFunctions = getRandomObjectiveFunctions(nRxns,nFunctions)

    rng('shuffle');

    ObjectiveFunctions=zeros(nRxns,nFunctions);

    for i=1:nFunctions
        ObjectiveFunctions(:,i) = getRandomObjectiveFunctionAndThreshold(nRxns);
    end