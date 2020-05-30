%% Script to prepare sbml file for ECM enumeration using all amino acids and malate as inputs

model  = xls2model('SupplementaryData4.xlsx');
model = changeObjective(model,'rxn06874');

%Remove sucrose, succinate and myo-inositol exchange and transport reactions as well as
%amino acid export

model_ECM = model;
toRemove = {'rxnTABCcpd00076','rxn08097','rxnTPScpd00036','rxn05152',...
    'DM_cpd00023','DM_cpd00033','DM_cpd00039',...
    'EX_cpd00076','EX_cpd00036','EX_cpd00121'};
model_ECM = removeRxns(model_ECM,model.rxns(242:255));
model_ECM = removeRxns(model_ECM,toRemove);

writeCbModel(model_ECM,'bacteroid_ECM.xml');

%Get indices of input/output metabolites for running ECM script

inds = [];
mets = {'cpd00001[e0]','cpd00007[e0]','cpd00009[e0]','cpd00011[e0]','cpd00107[e0]',...
    'cpd00130[e0]','cpd00048[e0]','cpd00067[e0]','cpd00227[e0]','cpd00528[e0]',...
    'cpd00421[c0]','cpd00214[c0]','cpd03802[c0]','cpd12836[c0]','cpdPG6[c0]',...
    'cpd00111[c0]','cpd00155[c0]','cpd00013[e0]','cpd00035[e0]','cpd00041[e0]',...
    'cpd11640[e0]','cpd00051[e0]','cpd00084[e0]','cpd00281[e0]','cpd00053[e0]',...
    'cpd00023[e0]','cpd00033[e0]','cpd00119[e0]','cpd00322[e0]','cpd00039[e0]',...
    'cpd00060[e0]','cpd00066[e0]','cpd00129[e0]','cpd00054[e0]','cpd00161[e0]',...
    'cpd00065[e0]','cpd00069[e0]','cpd00156[e0]',};

for i = mets
    ind = findMetIDs(model_ECM,i);
    inds = [inds;ind-1];
end

%% Prepare sbml file for ECM enumeration with sucrose as a carbon source

model  = xls2model('SupplementaryData4.xlsx');
model = changeObjective(model,'rxn06874');

% Remove succinate, malate and myo-inositol exchange and transport reactions as well as
% amino acid sinks and export

model_sucr = model;
toRemove = {'rxnTPScpd00130','rxn13794','rxnTPScpd00036','DM_cpd00039',...
    'EX_cpd00039','EX_cpd00119','EX_cpd00129','EX_cpd00281','EX_cpd00121'};
model_sucr = removeRxns(model_sucr,model.rxns(210:222));
model_sucr = removeRxns(model_sucr,model.rxns(224:228));
model_sucr = removeRxns(model_sucr,model.rxns(237:238));
model_sucr = removeRxns(model_sucr,model.rxns(242:255));
model_sucr = removeRxns(model_sucr,model.rxns(268:269));
model_sucr = removeRxns(model_sucr,model.rxns(273:280));
model_sucr = removeRxns(model_sucr,model.rxns(284:287));
model_sucr = removeRxns(model_sucr,model.rxns(296));
model_sucr = removeRxns(model_sucr,toRemove);

writeCbModel(model_sucr,'bacteroid_ECM_sucrose.xml');

%Get indices of input/output metabolites for running ECM script

inds_sucr = [];
mets_sucr = {'cpd00001[e0]','cpd00007[e0]','cpd00009[e0]','cpd00011[e0]','cpd00107[e0]',...
    'cpd00048[e0]','cpd00067[e0]','cpd00227[e0]','cpd00528[e0]',...
    'cpd00421[c0]','cpd00214[c0]','cpd03802[c0]','cpd12836[c0]','cpdPG6[c0]',...
    'cpd00111[c0]','cpd00155[c0]','cpd00013[e0]','cpd00035[e0]','cpd00041[e0]',...
    'cpd11640[e0]','cpd00076[e0]'};

for i = mets_sucr
    ind = findMetIDs(model_sucr,i);
    inds_sucr = [inds_sucr;ind-1];
end

