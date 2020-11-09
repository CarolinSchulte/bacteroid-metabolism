function [carbon,minO2,nit] = getMinO2(model,carbonExc,carbonBounds,O2Bounds)
 minO2 = [];
 carbon = [];
 nit = [];
 
 for i = carbonBounds
    model = changeRxnBounds(model,carbonExc,i,'b');
    for j = O2Bounds
        model = changeRxnBounds(model,'EX_cpd00007',j,'b');
        FBA = optimizeCbModel(model,'max',0,0);
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(O2Bounds)
            o2 = NaN;
        end
    end
    minO2 = [minO2;-o2];
    nit = [nit;FBA.f];
    if carbonExc == 'EX_cpd00130'
        carbon = [carbon;-i*4];
    elseif carbonExc =='EX_cpd00076'
        carbon = [carbon;-i*12];
 end