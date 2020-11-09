function [carbon,minO2,nit] = getMinO2_nitFixed(model,carbonExc,carbonBounds,O2Bounds,nit_target)
 minO2 = [];
 carbon = [];
 nit = [];
 
 for i = carbonBounds
    model = changeRxnBounds(model,carbonExc,i,'b');
    if nit_target(find(carbonBounds==i)) > 0
        model = changeRxnBounds(model,'rxn06874',nit_target(find(carbonBounds==i)),'l');
    else
        model = changeRxnBounds(model,'rxn06874',0,'l');
    end
    for j = O2Bounds
        model = changeRxnBounds(model,'EX_cpd00007',j,'b');
        try
            FBA = optimizeCbModel(model,'max',0,0);
        catch
        end
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(O2Bounds)
            o2 = NaN;
        end
    end
    if nit_target(find(carbonBounds==i)) > 0
        nit = [nit;FBA.f];
        minO2 = [minO2;-o2];
    else
        nit = [nit;NaN];
        minO2 = [minO2;NaN];
    end
    if carbonExc == 'EX_cpd00130'
        carbon = [carbon;-i*4];
    elseif carbonExc =='EX_cpd00076'
        carbon = [carbon;-i*12];
end