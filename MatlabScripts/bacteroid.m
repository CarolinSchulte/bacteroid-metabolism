%% Script for initialising bacteroid model

load iCS323.mat; %load model structure

%set lower bound of all exchange reactions to 0
[selExc, selUpt] = findExcRxns(model, 0, 1);
excRxns = model.rxns(selExc);
model = changeRxnBounds(model,excRxns,0,'l');

model = changeObjective(model,'rxn06874'); %set nitrogenase reaction as objective

model = changeRxnBounds(model,'EX_cpd00036',0,'b'); %close succinate exchange

%close amino acid transport reactions (except leucine, homoserine, GABA)
transportRxns = {'rxn05146','rxn10862','rxn08097','rxn05151','rxn05152','rxn05154',...
    'rxn05155','rxn10883','rxn05219','rxnTABCcpd00065','rxnTABCcpd00066',...
    'rxnTABCcpd00069', 'rxn05237','rxn05164','rxn05165','rxn05168','rxn05169',...
    'rxn05179'};

model = changeRxnBounds(model,transportRxns,0,'b');

%define freely exchanged metabolites: H+,N2,H2O,phosphate,sulfate,CO2,H2
excMets = {'EX_cpd00067','EX_cpd00528','EX_cpd00001','EX_cpd00009',...
    'EX_cpd00048','EX_cpd00011','EX_cpd11640'};

model = changeRxnBounds(model,excMets,-1000,'l');

%set O2 and malate uptake to 4 flux units
model = changeRxnBounds(model,'EX_cpd00007',-4,'b');
model = changeRxnBounds(model,'EX_cpd00130',-4,'b');
 
%provision of leucine, myo-inositol,homoserine, GABA by the plant
model = changeRxnBounds(model,'EX_cpd00107',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00121',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00227',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00281',-0.01,'l');

%set demand for amino acids (for protein biosynthesis)
demandAminoAcids = {'DM_cpd00023','DM_cpd00033','DM_cpd00035','DM_cpd00039',...
    'DM_cpd00041','DM_cpd00051','DM_cpd00053','DM_cpd00054','DM_cpd00060','DM_cpd00065',...
    'DM_cpd00066','DM_cpd00069','DM_cpd00084','DM_cpd00107','DM_cpd00119','DM_cpd00129',...
    'DM_cpd00156','DM_cpd00161','DM_cpd00322'};
model = changeRxnBounds(model,demandAminoAcids,0.01,'l');
model = changeRxnBounds(model,demandAminoAcids,0.05,'u');

%allow unlimted production of alanine and aspartate (secreted to the plant)
model = changeRxnBounds(model,'DM_cpd00035',1000,'u');
model = changeRxnBounds(model,'DM_cpd00041',1000,'u');

%minimum synthesis of lipids, homospermidine and glutathione
model = changeRxnBounds(model,'DM_cpdPG6',0.01,'l');
model = changeRxnBounds(model,'DM_cpd00214',0.01,'l');
model = changeRxnBounds(model,'DM_cpd03802',1e-5,'l');
model = changeRxnBounds(model,'DM_cpd00111',1e-5,'l');