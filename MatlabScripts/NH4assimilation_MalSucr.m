%Script to determine minimum oxygen demand for bacteroids using malate or
%sucrose as a carbon source; comparing scenarios with and without ammonia
%assimilation via GS-GOGAT

addpath('helper');

%Initialize wild-type and ammonia assimilating model with malate as a
%carbon source
bacteroid;
model_wt = model;
model_gs = model;

%For ammonia assimilation: minimum demand for glutamate
model_gs = changeRxnBounds(model_gs,'DM_cpd00023',4,'l');
model_gs = changeRxnBounds(model_gs,'DM_cpd00023',1000,'u');

%Set GABA, inositol and homoserine uptake to 0
optionalCarbonInputs = {'EX_cpd00281','EX_cpd00121','EX_cpd00227'};
model_wt = changeRxnBounds(model_wt,optionalCarbonInputs,0,'b');
model_gs = changeRxnBounds(model_gs,optionalCarbonInputs,0,'b');
 
% %Define interval for malate and oxygen uptake rates
fluxBounds_mal = [-0.1:-1:-55];
fluxBounds_o2 = [0:-0.1:-60];

 %Scan over malate uptake rates and find minimum O2 uptake required for
 %nitrogenase activity
[carbon_mal_gs,minO2_mal_gs,nit_mal_gs] = getMinO2(model_gs,'EX_cpd00130',fluxBounds_mal,fluxBounds_o2)
[carbon_mal_wt,minO2_mal_wt,nit_mal_wt] = getMinO2_nitFixed(model_wt,'EX_cpd00130',fluxBounds_mal,fluxBounds_o2,nit_mal_gs) 

 
%Initialize wild-type and ammonia assimilating model with sucrose as a
%carbon source
model_sucr = model;
model_sucr = changeRxnBounds(model_sucr,optionalCarbonInputs,0,'b');
model_sucr = changeRxnBounds(model_sucr,'EX_cpd00130',0,'b');

%For ammonia assimilation: minimum demand for glutamate
model_sucr_gs = model_sucr;
model_sucr_gs = changeRxnBounds(model_sucr_gs,'DM_cpd00023',4,'l');
model_sucr_gs = changeRxnBounds(model_sucr_gs,'DM_cpd00023',1000,'u');

%Define interval for sucrose and oxygen uptake rates
fluxBounds_sucr = [-0.1:-0.3:-18];
fluxBounds_o2 = [0:-0.1:-50];

[carbon_sucr_gs,minO2_sucr_gs,nit_sucr_gs] = getMinO2(model_sucr_gs,'EX_cpd00076',fluxBounds_sucr,fluxBounds_o2)
[carbon_sucr_wt,minO2_sucr_wt,nit_sucr_wt] = getMinO2_nitFixed(model_sucr,'EX_cpd00076',fluxBounds_sucr,fluxBounds_o2,nit_sucr_gs) 


