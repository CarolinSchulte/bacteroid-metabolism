# bacteroid-metabolism
Scripts to reproduce results for Carolin C. M. Schulte, Khushboo Borah, Rachel M. Wheatley, Jason J. Terpolilli, Gerhard Saalbach, Nick Crang, Daan H. de Groot, R. George Ratcliffe, Nicholas J. Kruger, Antonis Papachristodoulou, Philip S. Poole: "Metabolic constraints on nitrogen fixation by rhizobia in legume nodules" (*submitted*)  


All MATLAB scripts are based on the COBRA Toolbox v.3.0 ([Heirendt *et al.*, 2019](https://www.nature.com/articles/s41596-018-0098-2))

```
|- README
|
|- iCS323.mat                   # MATLAB structure of the bacteroid model iCS323
|
|- ecmtool/                     # forked from https://github.com/SystemsBioinformatics/ecmtool.git
|
| |- bacteroid_aminoacids.py    # extension of main.py to run conversion mode analysis on iCS323, 
|                                 using one amino acid at a time as an input
| |- ECM_iCC541.m               # MATLAB script to modify iCC541 (Contador et al., 2020, 
|                                 https://msystems.asm.org/content/5/1/e00516-19) for conversion mode analysis
| |- ECMinputs/                 # Excel files specifying inputs and ouputs for conversion mode analysis
| |- ECMresults/                # csv files with the conversion modes calculated for the different amino acid inputs
| |- models_bacteroid/          # sbml files of the models used for conversion mode analysis
|
|- MATLABScripts/             
|
| |- bacteroid.m                # initialise bacteroid model by setting exchange fluxes
| |- NH4assimiliation_MalSucr.m # compare minimum O2 demand for malate and sucrose with and without ammonia assimilation
| |- yield_MalSucr.m            # compare maximum nitrogenase activity for malate and sucrose
| |- findMaxNit.m               # helper function for determining maximum nitrogenase activity
| |- getMinO2.m                 # helper function for determining minimum oxygen demand
| |- getMinO2_nitFixed.m        # helper function for determining minimum oxygen demand while achieving the 
|                                 same nitrogenase activity as the non-ammonia assimilating model 

```
