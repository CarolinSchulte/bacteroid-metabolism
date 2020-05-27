model  = xls2model('SupplementaryData4.xlsx');
[selExc, selUpt] = findExcRxns(model, 0, 1);

excRxns = model.rxns(selExc);

model = changeRxnBounds(model,excRxns,0,'l');
model = changeRxnBounds(model,'EX_cpd00036',0,'b');
model = changeObjective(model,'rxn06874');

model = changeRxnBounds(model,model.rxns(210:222),0,'b');
model = changeRxnBounds(model,model.rxns(224:228),0,'b');

plantSupp = {'EX_cpd00067','EX_cpd00528',...
     'EX_cpd00001','EX_cpd00009','EX_cpd00048','EX_cpd00011',...
     'EX_cpd11640'};

model = changeRxnBounds(model,plantSupp,-1000,'l');

%Make sure that all models fix nitrogen (minimum flux through nitrogenase
%reaction)
model = changeRxnBounds(model,'rxn06874',0.01,'l');

%Set fixed O2 uptake rate to 10 flux units
model = changeRxnBounds(model,'EX_cpd00007',-10,'b');

%malate
model = changeRxnBounds(model,'EX_cpd00130',-10,'b');
 
% Provide leucine, myo-inositol,homoserine, GABA
model = changeRxnBounds(model,'EX_cpd00107',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00121',-0.01,'l');
model = changeRxnBounds(model,'EX_cpd00227',-1,'l');
model = changeRxnBounds(model,'EX_cpd00281',-1,'l');

%Set demand for amino acids, lipids, homospermidine and glutathione
model = changeRxnBounds(model,model.rxns(237:255),0.01,'l');
model = changeRxnBounds(model,'DM_cpdPG6',0.01,'l');
model = changeRxnBounds(model,'DM_cpd00214',0.01,'l');
model = changeRxnBounds(model,'DM_cpd03802',0.01,'l');
model = changeRxnBounds(model,'DM_cpd00111',0.01,'l');