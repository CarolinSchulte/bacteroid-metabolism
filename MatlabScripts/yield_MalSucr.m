%Script to determine maximum nitrogenase activity of bacteroids using
%malate or sucrose as a carbon source
clear
clc

%Load model and initialize
bacteroid;

%Set boundaries for models with malate and sucrose as carbon source
model_mal = model;

optionalCarbon = {'EX_cpd00281','EX_cpd00121','EX_cpd00227'};

model_mal = changeRxnBounds(model_mal,'EX_cpd00007',-4,'l');
model_mal = changeRxnBounds(model_mal,'EX_cpd00007',0,'u');
model_mal = changeRxnBounds(model_mal,optionalCarbon,0,'b');

model_sucr = model_mal;
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00130',0,'b');

fluxBounds_mal = [-50:0.5:0];
fluxBounds_sucr = [-17:0.2:0];

[carbon_mal,maxNit_mal] = findMaxNit(model_mal,'EX_cpd00130',fluxBounds_mal);
[carbon_sucr,maxNit_sucr] = findMaxNit(model_sucr,'EX_cpd00076',fluxBounds_sucr);


