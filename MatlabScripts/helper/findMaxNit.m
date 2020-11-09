function [carbon,nit] = findMaxNit(model,carbonExc,carbonBounds)
carbon = [];
nit = [];
o2 = [];

for i = carbonBounds
    try
        model = changeRxnBounds(model,carbonExc,i,'b');
        FBA = optimizeCbModel(model,'max',0,0);
        yield = FBA.f;
        o2_tmp = -FBA.x(findRxnIDs(model,'EX_cpd00007'));
        nit = [nit;yield];
        o2 = [o2;o2_tmp];
        if carbonExc =='EX_cpd00130'
            carbon = [carbon;-i*4];
        elseif carbonExc =='EX_cpd00076'
            carbon = [carbon;-i*12];
        end
    catch
    end
end