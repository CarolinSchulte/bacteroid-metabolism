%Load model and initialize
%Bacteroid;

%Initialize wild-type and ammonia assimilating model
% model_wt = model;
% 
% %For ammonia assimilation: minimum demand for glutamate
% model_gs = model;
% model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1,'l');
% model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1000,'u');
% 
% %Define range of oxygen uptake and set GABA uptake to 0
% model_wt = changeRxnBounds(model_wt,'EX_cpd00007',-10,'l');
% model_wt = changeRxnBounds(model_wt,'EX_cpd00007',0,'u');
% model_wt = changeRxnBounds(model_wt,'EX_cpd00281',0,'b');
% model_gs = changeRxnBounds(model_gs,'EX_cpd00007',-10,'l');
% model_gs = changeRxnBounds(model_gs,'EX_cpd00007',0,'u');
% model_gs = changeRxnBounds(model_gs,'EX_cpd00281',0,'b');
% 
% %Define range of malate uptake rates
% fluxBounds_mal = [-0.1:-0.5:-25];
% 
% mal_wt = [];
% nit_max_wt = [];
% o2_wt = [];
% mal_gs = [];
% nit_max_gs = [];
% o2_gs= [];
% 
% %Find maximum nitrogenase activity for each carbon uptake rate
% for i = fluxBounds_mal
%     model_gs = changeRxnBounds(model_gs,'EX_cpd00130',i,'b');
%     FBA = optimizeCbModel(model_gs,'max');
%     mal_gs = [mal_gs;-i];
%     nit_max_gs = [nit_max_gs;FBA.f];
%     if FBA.f > 0 
%         o2_gs = [o2_gs;FBA.v(264)];
%     else
%         o2_gs = [o2_gs;NaN];
%     end
%     model_wt = changeRxnBounds(model_wt,'EX_cpd00130',i,'b');
%     FBA = optimizeCbModel(model_wt,'max');
%     
%     if nit_max_gs(length(nit_max_gs)) > 0
%         mal_wt = [mal_wt;-i];
%         nit_max_wt = [nit_max_wt;FBA.f];
%     else
%         mal_wt = [mal_wt;NaN];
%         nit_max_wt = [nit_max_wt;NaN];
%     end
%     if FBA.f > 0 
%         o2_wt = [o2_wt;FBA.v(264)];
%     else
%         o2_wt = [o2_wt;NaN];
%     end
% end 
% 
% plot(mal_wt,nit_max_wt,'b.'); hold on
% plot(mal_gs,nit_max_gs,'r.')

%Initialize wild-type and ammonia assimilating model
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
plot(mal_wt,nit_wt,'b*');
plot(mal_gs,nit_gs,'r*');
