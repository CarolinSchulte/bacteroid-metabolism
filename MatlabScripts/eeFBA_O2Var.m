%% Sequence of function calls for eeFBA

%Functions were modified from scripts provided by Dr Chiara Damiani
%from the work in Damiani et al. PLoS Comput Biol 2017 Sep 28;13(9):e1005758
%doi: 10.1371/journal.pcbi.1005758

addpath('eeFBA');
%Initialize metabolic model
bacteroid_eeFBA;

%Define number of objective functions to get
nObj = 50000;
ObjectiveFunctions = getRandomObjectiveFunctions(size((model.rxns),1),nObj);

%Define interval for oxygen uptake rates  
fluxBounds = [-30:0.5:0];
flux2change = 'EX_cpd00007';

%Calculate flux distributions for ensemble at varying oxygen uptake rate
%and fixed malate uptake rate

[NoAa_O2Var_60_nfixing]= getMetabolicResponses(model,flux2change,fluxBounds,'b',ObjectiveFunctions,[])

