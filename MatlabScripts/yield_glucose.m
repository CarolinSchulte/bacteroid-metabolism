%Load model and initialize
%bacteroid;

%Initialize models with malate and glucose;
model_mal = model;
model_glc = model;

model_mal = changeRxnBounds(model_mal,'EX_cpd00007',-10,'l');
model_mal = changeRxnBounds(model_mal,'EX_cpd00007',0,'u');
model_mal = changeRxnBounds(model_mal,'EX_cpd00281',0,'b');

model_glc = addSinkReactions(model_glc,'cpd00027[c0]');
model_glc = changeRxnBounds(model_glc,'EX_cpd00007',-10,'l');
model_glc = changeRxnBounds(model_glc,'EX_cpd00007',0,'u');
model_glc = changeRxnBounds(model_glc,'EX_cpd00281',0,'b');
model_glc = changeRxnBounds(model_glc,'EX_cpd00130',0,'b');


carbon_mal = [];
nit_mal = [];
o2_mal = [];
carbon_glc = [];
nit_glc = [];
o2_glc = [];

%% Find maximum nitrogenase activity for given carbon uptake rate

fluxBounds_carbon = [-50:0.8:0];
for i = fluxBounds_carbon
    try
        model_mal = changeRxnBounds(model_mal,'EX_cpd00130',i,'b');
        FBA = optimizeCbModel(model_mal,'max');
        yield_mal = FBA.f;
        o2_mal_tmp = -FBA.x(264);
        carbon_mal = [carbon_mal;-4*i];
        nit_mal = [nit_mal;yield_mal];
        o2_mal = [o2_mal;o2_mal_tmp];
    catch
    end
end

fluxBounds_carbon = [-17:0.6:0];
for i = fluxBounds_carbon
    try
        model_glc = changeRxnBounds(model_glc,'sink_cpd00027[c0]',i,'b');
        FBA = optimizeCbModel(model_glc,'max');
        yield_glc = FBA.f;
        o2_glc_tmp = -FBA.x(264);
        carbon_glc = [carbon_glc;-6*i];
        nit_glc = [nit_glc;yield_glc];
        o2_glc = [o2_glc;o2_glc_tmp];
    catch
    end
end


plot(carbon_mal,nit_mal,'r.'); hold on
plot(carbon_glc,nit_glc,'b-');


%% Minimum O2 requirement
%Initialize models with malate and glucose;
model_mal = model;
model_glc = model;

model_mal = changeRxnBounds(model_mal,'EX_cpd00007',-10,'l');
model_mal = changeRxnBounds(model_mal,'EX_cpd00007',0,'u');
model_mal = changeRxnBounds(model_mal,'EX_cpd00281',0,'b');

model_glc = addSinkReactions(model_glc,'cpd00027[c0]');
model_glc = changeRxnBounds(model_glc,'EX_cpd00007',-10,'l');
model_glc = changeRxnBounds(model_glc,'EX_cpd00007',0,'u');
model_glc = changeRxnBounds(model_glc,'EX_cpd00281',0,'b');
model_glc = changeRxnBounds(model_glc,'EX_cpd00130',0,'b');

%Define intervals for glucose, malate and O2 uptake rates
fluxBounds_glc = [-20:0.5:-0.1];
fluxBounds_mal = [-30:0.8:-0.1];
fluxBounds_o2 = [0:-0.1:-50];

 o2_mal = [];
 carbon_mal = [];
 o2_glc = [];
 carbon_glc = [];

for i = fluxBounds_mal
    model_mal = changeRxnBounds(model_mal,'EX_cpd00130',i,'b');
    for j = fluxBounds_o2
        model_mal = changeRxnBounds(model_mal,'EX_cpd00007',j,'b');
        FBA = optimizeCbModel(model_mal,'max');
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(fluxBounds_o2)
            o2 = NaN;
        end
    end
    o2_mal = [o2_mal;-o2];
    carbon_mal = [carbon_mal;-4*i];
end 

for i = fluxBounds_glc
    model_glc = changeRxnBounds(model_glc,'sink_cpd00027[c0]',i,'b');
    for j = fluxBounds_o2
        model_glc = changeRxnBounds(model_glc,'EX_cpd00007',j,'b');
        FBA = optimizeCbModel(model_glc,'max');
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(fluxBounds_o2)
            o2 = NaN;
        end
    end
    o2_glc = [o2_glc;-o2];
    carbon_glc = [carbon_glc;-6*i];
end 

plot(carbon_mal,o2_mal,'b.'); hold on
plot(carbon_glc,o2_glc,'r-')
    