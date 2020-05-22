%Load model and initialize
%Bacteroid;

%Initialize models with malate and sucrose;
% model_mal = model;
% model_sucr = model;
% 
% model_mal = changeRxnBounds(model_mal,'EX_cpd00007',-10,'l');
% model_mal = changeRxnBounds(model_mal,'EX_cpd00007',0,'u');
% model_mal = changeRxnBounds(model_mal,'EX_cpd00281',0,'b');
% 
% model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',-10,'l');
% model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',0,'u');
% model_sucr = changeRxnBounds(model_sucr,'EX_cpd00281',0,'b');
% model_sucr = changeRxnBounds(model_sucr,'EX_cpd00130',0,'b');
% 
% % model_sucr_gs = model_sucr;
% % model_sucr_gs = changeRxnBounds(model_sucr_gs,'DM_cpd00023',1,'l');
% % model_sucr_gs = changeRxnBounds(model_sucr_gs,'DM_cpd00023',1000,'u');
% 
% fluxBounds_carbon = [-50:0.5:0];
% carbon_mal = [];
% nit_mal = [];
% o2_mal = [];
% carbon_sucr = [];
% nit_sucr = [];
% o2_sucr = [];
% 
% %Find maximum nitrogenase activity for given carbon uptake rate
% 
% for i = fluxBounds_carbon
%     try
%         model_mal = changeRxnBounds(model_mal,'EX_cpd00130',i,'b');
%         FBA = optimizeCbModel(model_mal,'max');
%         yield_mal = FBA.f;
%         o2_mal_tmp = -FBA.x(264);
%         carbon_mal = [carbon_mal;-4*i];
%         nit_mal = [nit_mal;yield_mal];
%         o2_mal = [o2_mal;o2_mal_tmp];
%     catch
%     end
% end
% 
% fluxBounds_carbon = [-17:0.2:0];
% for i = fluxBounds_carbon
%     try
%         model_sucr = changeRxnBounds(model_sucr,'EX_cpd00076',i,'b');
%         FBA = optimizeCbModel(model_sucr,'max');
%         yield_sucr = FBA.f;
%         o2_sucr_tmp = -FBA.x(264);
%         carbon_sucr = [carbon_sucr;-12*i];
%         nit_sucr = [nit_sucr;yield_sucr];
%         o2_sucr = [o2_sucr;o2_sucr_tmp];
%     catch
%     end
% end
% 
% 
% plot(carbon_mal,nit_mal,'r.'); hold on
% plot(carbon_sucr,nit_sucr,'b-');


%Minimum O2 requirement
%Initialize models with malate and sucrose;
model_mal = model;
model_sucr = model;

model_mal = changeRxnBounds(model_mal,'EX_cpd00007',-10,'l');
model_mal = changeRxnBounds(model_mal,'EX_cpd00007',0,'u');
model_mal = changeRxnBounds(model_mal,'EX_cpd00281',0,'b');

model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',-10,'l');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',0,'u');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00281',0,'b');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00130',0,'b');

%Define intervals for sucrose, malate and O2 uptake rates
fluxBounds_sucr = [-20:0.2:-0.1];
fluxBounds_mal = [-30:0.8:-0.1];
fluxBounds_o2 = [0:-0.1:-50];

 o2_mal = [];
 carbon_mal = [];
 o2_sucr = [];
 carbon_sucr = [];

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

for i = fluxBounds_sucr
    model_sucr = changeRxnBounds(model_sucr,'EX_cpd00076',i,'b');
    for j = fluxBounds_o2
        model_sucr = changeRxnBounds(model_sucr,'EX_cpd00007',j,'b');
        FBA = optimizeCbModel(model_sucr,'max');
        if FBA.f > 0
            o2 = j;
            break
        end
        if j == min(fluxBounds_o2)
            o2 = NaN;
        end
    end
    o2_sucr = [o2_sucr;-o2];
    carbon_sucr = [carbon_sucr;-12*i];
end 

plot(carbon_mal,o2_mal,'b.'); hold on
plot(carbon_sucr,o2_sucr,'r-')
    