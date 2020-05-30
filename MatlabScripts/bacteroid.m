%Use model provided in supplementary material
model  = xls2model('SupplementaryData4.xlsx');

%Set lower bound of all exchange reactions to 0
[selExc, selUpt] = findExcRxns(model, 0, 1);
excRxns = model.rxns(selExc);
model = changeRxnBounds(model,excRxns,0,'l');

%Set nitrogenase reaction as objective
model = changeObjective(model,'rxn06874');

%Prevent succinate secretion
model = changeRxnBounds(model,'EX_cpd00036',0,'b');

%Close amino acid transport reactions (except leucine, homoserine, GABA)
model = changeRxnBounds(model,model.rxns(210:222),0,'b');
model = changeRxnBounds(model,model.rxns(224:228),0,'b');

%Define exchange metabolites: H+,N2,H2O,phosphate,sulfate,CO2,H2
excMets = {'EX_cpd00067','EX_cpd00528',...
     'EX_cpd00001','EX_cpd00009','EX_cpd00048','EX_cpd00011',...
     'EX_cpd11640'};

model = changeRxnBounds(model,excMets,-1000,'l');

%Set O2 and malate uptake to 10 flux units
model = changeRxnBounds(model,'EX_cpd00007',-10,'b');
model = changeRxnBounds(model,'EX_cpd00130',-10,'b');
 
%Provision of leucine, myo-inositol,homoserine, GABA by the plant
model = changeRxnBounds(model,'EX_cpd00107',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00121',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00227',-1,'l');
model = changeRxnBounds(model,'EX_cpd00281',-1,'l');

%Set demand for amino acids (for protein biosynthesis)
model = changeRxnBounds(model,model.rxns(237:255),0.01,'l');
model = changeRxnBounds(model,model.rxns(237:255),0.05,'u');

%Allow unlimted production of alanine and aspartate (secreted to the plant)
model = changeRxnBounds(model,'DM_cpd00035',1000,'u');
model = changeRxnBounds(model,'DM_cpd00041',1000,'u');

%Minimum synthesis of lipids, homospermidine and glutathione
model = changeRxnBounds(model,'DM_cpdPG6',0.01,'l');
model = changeRxnBounds(model,'DM_cpd00214',0.01,'l');
model = changeRxnBounds(model,'DM_cpd03802',0.01,'l');
model = changeRxnBounds(model,'DM_cpd00111',0.01,'l');

%Flux Variability Analysis and PhPP
%[minFlux, maxFlux] = fluxVariability(model, 95, 'max', model.rxns, 0, 0)
%[growthRates, shadowPrices1, shadowPrices2] = phenotypePhasePlane(model,'EX_cpd00130','EX_cpd00007',50,50,50);