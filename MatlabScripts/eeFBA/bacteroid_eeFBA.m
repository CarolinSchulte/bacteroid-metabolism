model  = xls2model('SupplementaryData4.xlsx');
[selExc, selUpt] = findExcRxns(model, 0, 1);

excRxns = model.rxns(selExc);

model = changeRxnBounds(model,excRxns,0,'l');
model = changeRxnBounds(model,'EX_cpd00036',0,'b');
model = changeObjective(model,'rxn06874');

%Close amino acid transport reactions (except leucine, homoserine, GABA)
transportRxns = {'rxn05146','rxn10862','rxn08097','rxn05151','rxn05152','rxn05154',...
    'rxn05155','rxn10883','rxn05219','rxnTABCcpd00065','rxnTABCcpd00066','rxnTABCcpd00069',...
    'rxn05237','rxn05164','rxn05165','rxn05168','rxn05169','rxn05179'};
model = changeRxnBounds(model,transportRxns,0,'b');

plantSupp = {'EX_cpd00067','EX_cpd00528',...
     'EX_cpd00001','EX_cpd00009','EX_cpd00048','EX_cpd00011',...
     'EX_cpd11640'};

model = changeRxnBounds(model,plantSupp,-1000,'l');

%Make sure that all models have nitrogenase activity
model = changeRxnBounds(model,'rxn06874',0.01,'l');

%Set malate and oxygen uptake rate to 10 flux units
model = changeRxnBounds(model,'EX_cpd00007',-10,'b');
model = changeRxnBounds(model,'EX_cpd00130',-10,'b');
 
% Provide leucine, myo-inositol,homoserine, GABA
model = changeRxnBounds(model,'EX_cpd00107',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00121',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00227',-1,'l');
model = changeRxnBounds(model,'EX_cpd00281',-1,'l');

%Set demand for amino acids, lipids, homospermidine and glutathione
demandAminoAcids = {'DM_cpd00023','DM_cpd00033','DM_cpd00035','DM_cpd00039',...
    'DM_cpd00041','DM_cpd00051','DM_cpd00053','DM_cpd00054','DM_cpd00060','DM_cpd00065',...
    'DM_cpd00066','DM_cpd00069','DM_cpd00084','DM_cpd00107','DM_cpd00119','DM_cpd00129',...
    'DM_cpd00156','DM_cpd00161','DM_cpd00322'};
model = changeRxnBounds(model,demandAminoAcids,0.01,'l');
model = changeRxnBounds(model,'DM_cpdPG6',0.01,'l');
model = changeRxnBounds(model,'DM_cpd00214',0.01,'l');
model = changeRxnBounds(model,'DM_cpd03802',0.01,'l');
model = changeRxnBounds(model,'DM_cpd00111',0.01,'l');