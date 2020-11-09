%%Script to prepare iGD1348 for use with ecmtool

iCC541 = readCbModel('iCC541.xml');
iCC541 = changeObjective(iCC541,'r_0277');


%Remove unwanted exchange and transport reactions
iCC541 = removeRxns(iCC541,'r_0521');
iCC541 = addSinkReactions(iCC541,'Symbiotic_Cofactors[c]');


iCC541 = addReaction(iCC541,'alanine_export',...
'reactionFormula','ala__L[c] -> ala__L[e]');
iCC541 = addReaction(iCC541,'aspartate_export',...
'reactionFormula','asp__L[c] -> asp__L[e]');
iCC541 = addReaction(iCC541,'palmitate_export',...
'reactionFormula','hdca[c] -> hdca[e]');
iCC541 = addSinkReactions(iCC541,'hdca[e]');

writeCbModel(iCC541,'iCC541_ECM.xml');


%Find indices of input/output metabolites
inds_inputs_iCC541 = [];
inputs_iCC541 = {'succ[e]','homocitrate[e]','fe2[e]','n2[e]','pi[e]','so4[e]',...
    'o2[e]','h[e]','inost[e]','mal__L[e]','mg2[e]','cbl1[e]','mobd[e]',...
    'thm[e]','zn2[e]','glu__L[e]'};

for i = inputs_iCC541
    ind = findMetIDs(iCC541,i);
    inds_inputs_iCC541 = [inds_inputs_iCC541;ind-1];
end

inds_outputs_iCC541 = [];
outputs_iCC541 = {'co2[e]','ala__L[e]','nh3[e]','h2o[e]','asp__L[e]',...
    'fixedNH3[e]','Symbiotic_Cofactors[c]','h2[e]','phb[c]','glycogen[c]',...
    'hdca[e]'};

for i = outputs_iCC541
    ind = findMetIDs(iCC541,i);
    inds_outputs_iCC541 = [inds_outputs_iCC541;ind-1];
end

inds_hidden_iCC541 = [];
hidden_iCC541 = {'homocitrate[e]','fe2[e]','so4[e]','mg2[e]','cbl1[e]',...
    'mobd[e]','thm[e]','zn2[e]','Symbiotic_Cofactors[c]'};

for i = hidden_iCC541
    ind = findMetIDs(iCC541,i);
    inds_hidden_iCC541 = [inds_hidden_iCC541;ind-1];
end