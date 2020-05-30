# bacteroid-metabolism
Scripts to reproduce results for Carolin C. M. Schulte, Rachel M. Wheatley, Jason J. Terpolilli, Gerhard Saalbach, Daan H. de Groot, Antonis Papachristodoulou, Philip S. Poole: "How legumes control nitrogen fixation by root nodule bacteria" (*submitted*)

**MatlabScripts**\
eeFBA\
*eeFBA_MalVar.m*: script for eeFBA computations for varying malate uptake rates; functions are based on the scripts used in Damiani *et al.*, *PLoS Comput Biol* 2017 Sep 28;13(9):e1005758, doi: 10.1371/journal.pcbi.1005758 

*bacteroid.m*: sets constraints for general FBA-based computations

*ketoglutarate_NH4assimilation.m*: comparing oxygen demand and nitrogenase activity on 2-oxoglutarate with and without ammonia assimilation; computations for Fig.4B

*malate_NH4assimilation.m*:comparing oxygen demand and nitrogenase activity on L-malate with and without ammonia assimilation; computations for Fig.4A

*sucrmal_NH4assimilation.m*:comparing oxygen demand and nitrogenase activity on sucrose or malate with and without ammonia assimilation; computations for Fig.S9

*yield_sucrose.m*: comapring maximum nitrogenase activity and minimum oxygen demand for bacteroids using malate or sucrose as a carbon source; computations for Fig.5A-B

*yield_glucose.m*: comapring maximum nitrogenase activity and minimum oxygen demand for bacteroids using malate or glucose as a carbon source; computations for Fig.S7

*ECM_helper.m*: script for creating sbml files to run ECM enumeration either with malate and amino acids or with sucrose


**sbml_files**\
*bacteroid_ECM.xml*: sbml file for running ECM enumeration with malate and amino acids as inputs

*bacteroid_ECM_sucrose.xml*: sbml file for running ECM enumeration with sucrose as a carbon source

*iCS320.xml*: sbml for the model iCS320, which was used for FBA-based computations


*bacteroid_ecminput.csv*: contains description and indeces for metabolites used for ECM enumeration with malate and amino acids as inputs; indeces apply to the sbml file bacteroid_ECM.xml

*bacteroid_ecminput_sucrose.csv*: contains description and indeces for metabolites used for ECM enumeration with sucrose as a carbon source; indeces apply to the sbml file bacteroid_ECM_sucrose.xml
