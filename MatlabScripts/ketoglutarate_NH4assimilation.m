%Load model and initialize
%bacteroid;

%Initialize wild-type and ammonia assimilating model; set malate exchange
%reaction to 0 and add sink for 2-ketoglutarate
model_wt = model;
model_wt = addSinkReactions(model_wt,'cpd00024[c0]');
model_wt = changeRxnBounds(model_wt,'EX_cpd00130',0,'b');
model_wt = changeRxnBounds(model_wt,'EX_cpd00281',0,'b');
model_wt = changeRxnBounds(model_wt,'EX_cpd00007',-10,'l');
model_wt = changeRxnBounds(model_wt,'EX_cpd00007',0,'u');

model_gs = model;
model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1,'l');
model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1000,'u');
model_gs = addSinkReactions(model_gs,'cpd00024[c0]');
model_gs = changeRxnBounds(model_gs,'EX_cpd00130',0,'b');
model_gs = changeRxnBounds(model_gs,'EX_cpd00281',0,'b');
model_gs = changeRxnBounds(model_gs,'EX_cpd00007',-10,'l');
model_gs = changeRxnBounds(model_gs,'EX_cpd00007',0,'u');


fluxBounds_kg = [-0.1:-0.5:-25];

kg_wt = [];
nit_max_wt = [];
o2_wt = [];
kg_gs = [];
nit_max_gs = [];
o2_gs = [];

%Calculate maximum nitrogenase activity at each 2-ketoglutarate uptake rate

for i = fluxBounds_kg
    model_gs = changeRxnBounds(model_gs,'sink_cpd00024[c0]',i,'b');
    FBA = optimizeCbModel(model_gs,'max');
    kg_gs = [kg_gs;-i];
    nit_max_gs = [nit_max_gs;FBA.f];
    if FBA.f > 0 
        o2_gs = [o2_gs;FBA.v(264)];
    else
        o2_gs = [o2_gs;NaN];
    end
    model_wt = changeRxnBounds(model_wt,'sink_cpd00024[c0]',i,'b');
    FBA = optimizeCbModel(model_wt,'max');
        if nit_max_gs(length(nit_max_gs)) > 0
        kg_wt = [kg_wt;-i];
        nit_max_wt = [nit_max_wt;FBA.f];
    else
        kg_wt = [kg_wt;NaN];
        nit_max_wt = [nit_max_wt;NaN];
    end
    if FBA.f > 0 
        o2_wt = [o2_wt;FBA.v(264)];
    else
        o2_wt = [o2_wt;NaN];
    end
end 

plot(kg_wt,nit_max_wt,'b.'); hold on
plot(kg_gs,nit_max_gs,'r.')
 

%Initialize wild-type and ammonia assimilating model; set malate exchange
%reaction to 0 and add sink for 2-ketoglutarate
% model_wt = model;
% model_wt = addSinkReactions(model_wt,'cpd00024[c0]');
% model_wt = changeRxnBounds(model_wt,'EX_cpd00130',0,'b');
% model_wt = changeRxnBounds(model_wt,'EX_cpd00281',0,'b');
% model_wt = changeRxnBounds(model_wt,'EX_cpd00007',-10,'l');
% model_wt = changeRxnBounds(model_wt,'EX_cpd00007',0,'u');
% 
% model_gs = model;
% model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1,'l');
% model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1000,'u');
% model_gs = addSinkReactions(model_gs,'cpd00024[c0]');
% model_gs = changeRxnBounds(model_gs,'EX_cpd00130',0,'b');
% model_gs = changeRxnBounds(model_gs,'EX_cpd00281',0,'b');
% model_gs = changeRxnBounds(model_gs,'EX_cpd00007',-10,'l');
% model_gs = changeRxnBounds(model_gs,'EX_cpd00007',0,'u');
% 
% fluxBounds_kg = [-0.1:-0.5:-25];
% fluxBounds_o2 = [0:-0.1:-50];
% 
% o2_min_wt = [];
% kg_wt = [];
% nit_wt = [];
% o2_min_gs = [];
% kg_gs = [];
% nit_gs = [];
% 
% for i = fluxBounds_kg
%     model_gs = changeRxnBounds(model_gs,'sink_cpd00024[c0]',i,'b');
%     for j = fluxBounds_o2
%         model_gs = changeRxnBounds(model_gs,'EX_cpd00007',j,'b');
%         FBA = optimizeCbModel(model_gs,'max');
%         if FBA.f > 0
%             o2 = j;
%             break
%         end
%         if j == min(fluxBounds_o2)
%             o2 = NaN;
%         end
%     end
%     o2_min_gs = [o2_min_gs;-o2];
%     kg_gs = [kg_gs;-i];
%     nit_gs = [nit_gs;FBA.f];
% end 
% 
% 
% for i = fluxBounds_kg
%     model_wt = changeRxnBounds(model_wt,'sink_cpd00024[c0]',i,'b');
%     if nit_gs(find(fluxBounds_kg==i)) > 0
%         model_wt = changeRxnBounds(model_wt,'rxn06874',nit_gs(find(fluxBounds_kg==i)),'l');
%     else
%         model_wt = changeRxnBounds(model_wt,'rxn06874',0,'l');
%     end
%     for j = fluxBounds_o2
%         model_wt = changeRxnBounds(model_wt,'EX_cpd00007',j,'b');
%         try
%             FBA = optimizeCbModel(model_wt,'max');
%         catch
%         end
%         if FBA.f > 0
%             o2 = j;
%             break
%         end
%         if j == min(fluxBounds_o2)
%             o2 = NaN;
%         end
%     end
%     if nit_gs(find(fluxBounds_kg==i)) > 0
%         nit_wt = [nit_wt;FBA.f];
%         o2_min_wt = [o2_min_wt;-o2];
%     else
%         nit_wt = [nit_wt;NaN];
%         o2_min_wt = [o2_min_wt;NaN];
%     end
%     kg_wt = [kg_wt;-i];
% end 
% 
% 
% plot(kg_wt,o2_min_wt,'b.'); hold on
% plot(kg_gs,o2_min_gs,'r.');
% plot(kg_wt,nit_wt,'b*');
% plot(kg_gs,nit_gs,'r*');
