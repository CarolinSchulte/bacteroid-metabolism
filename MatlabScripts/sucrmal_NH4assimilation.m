%Initialize wild-type and ammonia assimilating model
bacteroid;
model_wt = model;

%For ammonia assimilation: minimum demand for glutamate
model_gs = model;
model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1,'l');
model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1000,'u');

%Define range of oxygen uptake and set GABA uptake to 0
model_wt = changeRxnBounds(model_wt,'EX_cpd00007',-10,'l');
model_wt = changeRxnBounds(model_wt,'EX_cpd00007',0,'u');
model_wt = changeRxnBounds(model_wt,'EX_cpd00281',0,'b');
model_gs = changeRxnBounds(model_gs,'EX_cpd00007',-10,'l');
model_gs = changeRxnBounds(model_gs,'EX_cpd00007',0,'u');
model_gs = changeRxnBounds(model_gs,'EX_cpd00281',0,'b');

%Define interval for malate and oxygen uptake rates
fluxBounds_mal = [-0.1:-0.5:-25];
fluxBounds_o2 = [0:-0.1:-50];

 o2_min_wt = [];
 mal_wt = [];
 nit_wt = [];
 o2_min_gs = [];
 mal_gs = [];
 nit_gs = [];
 
 %Scan over malate uptake rates and find minimum O2 uptake required for
 %nitrogenase activity
 
 for i = fluxBounds_mal
    model_gs = changeRxnBounds(model_gs,'EX_cpd00130',i,'b');
    for j = fluxBounds_o2
        model_gs = changeRxnBounds(model_gs,'EX_cpd00007',j,'b');
        FBA = optimizeCbModel(model_gs,'max');
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(fluxBounds_o2)
            o2 = NaN;
        end
    end
    nit_gs = [nit_gs;FBA.f];
    o2_min_gs = [o2_min_gs;-o2];
    mal_gs = [mal_gs;-i];
 end 

%Repeat computation for wild-type model, setting lower bound for
%nitrogenase to the same value as ammonia-assimilating model

for i = fluxBounds_mal
    model_wt = changeRxnBounds(model_wt,'EX_cpd00130',i,'b');
    if nit_gs(find(fluxBounds_mal==i)) > 0
        model_wt = changeRxnBounds(model_wt,'rxn06874',nit_gs(find(fluxBounds_mal==i)),'l');
    else
        model_wt = changeRxnBounds(model_wt,'rxn06874',0,'l');
    end
    for j = fluxBounds_o2
        model_wt = changeRxnBounds(model_wt,'EX_cpd00007',j,'b');
        try
            FBA = optimizeCbModel(model_wt,'max');
        catch
        end
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(fluxBounds_o2)
            o2 = NaN;
        end
    end
    if nit_gs(find(fluxBounds_mal==i)) > 0
        nit_wt = [nit_wt;FBA.f];
        o2_min_wt = [o2_min_wt;-o2];
    else
        nit_wt = [nit_wt;NaN];
        o2_min_wt = [o2_min_wt;NaN];
    end
    mal_wt = [mal_wt;-i];
end 


plot(mal_wt,o2_min_wt,'b.'); hold on
plot(mal_gs,o2_min_gs,'r.');
% plot(mal_wt,nit_wt,'b*');
% plot(mal_gs,nit_gs,'r*');

%Initialize wild-type and ammonia assimilating model
model_sucr = model;
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',-10,'l');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',0,'u');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00281',0,'b');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00130',0,'b');

%For ammonia assimilation: minimum demand for glutamate
model_sucr_gs = model_sucr;
model_sucr_gs = changeRxnBounds(model_sucr_gs,'DM_cpd00023',1,'l');
model_sucr_gs = changeRxnBounds(model_sucr_gs,'DM_cpd00023',1000,'u');

%Define range of oxygen uptake and set GABA uptake to 0
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',-10,'l');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',0,'u');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00281',0,'b');
model_sucr_gs = changeRxnBounds(model_sucr_gs,'EX_cpd00007',-10,'l');
model_sucr_gs = changeRxnBounds(model_sucr_gs,'EX_cpd00007',0,'u');
model_sucr_gs = changeRxnBounds(model_sucr_gs,'EX_cpd00281',0,'b');

%Define interval for sucrose and oxygen uptake rates
fluxBounds_sucr = [-0.1:-0.2:-18];
fluxBounds_o2 = [0:-0.1:-50];

 o2_min_sucr_wt = [];
 sucr_wt = [];
 nit_sucr_wt = [];
 o2_min_sucr_gs = [];
 sucr_gs = [];
 nit_sucr_gs = [];
 
 %Scan over sucrose uptake rates and find minimum O2 uptake required for
 %nitrogenase activity
 
 for i = fluxBounds_sucr
    model_sucr_gs = changeRxnBounds(model_sucr_gs,'EX_cpd00076',i,'b');
    for j = fluxBounds_o2
        model_sucr_gs = changeRxnBounds(model_sucr_gs,'EX_cpd00007',j,'b');
        FBA = optimizeCbModel(model_sucr_gs,'max');
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(fluxBounds_o2)
            o2 = NaN;
        end
    end
    nit_sucr_gs = [nit_sucr_gs;FBA.f];
    o2_min_sucr_gs = [o2_min_sucr_gs;-o2];
    sucr_gs = [sucr_gs;-i];
 end 

%Repeat computation for wild-type model, setting lower bound for
%nitrogenase to the same value as ammonia-assimilating model

for i = fluxBounds_sucr
    model_sucr = changeRxnBounds(model_sucr,'EX_cpd00076',i,'b');
    if nit_sucr_gs(find(fluxBounds_sucr==i)) > 0
        model_sucr = changeRxnBounds(model_sucr,'rxn06874',nit_sucr_gs(find(fluxBounds_sucr==i)),'l');
    else
        model_sucr = changeRxnBounds(model_sucr,'rxn06874',0,'l');
    end
    for j = fluxBounds_o2
        model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',j,'b');
        try
            FBA = optimizeCbModel(model_sucr,'max');
        catch
        end
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(fluxBounds_o2)
            o2 = NaN;
        end
    end
    if nit_sucr_gs(find(fluxBounds_sucr==i)) > 0
        nit_sucr_wt = [nit_sucr_wt;FBA.f];
        o2_min_sucr_wt = [o2_min_sucr_wt;-o2];
    else
        nit_sucr_wt = [nit_sucr_wt;NaN];
        o2_min_sucr_wt = [o2_min_sucr_wt;NaN];
    end
    sucr_wt = [sucr_wt;-i];
end 


plot(sucr_wt,o2_min_sucr_wt,'b*'); hold on
plot(sucr_gs,o2_min_sucr_gs,'r*');
% plot(sucr_wt,nit_sucr_wt,'b*');
% plot(sucr_gs,nit_sucr_gs,'r*');
