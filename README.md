# bacteroid-metabolism
Scripts to reproduce results for Carolin C. M. Schulte, Khushboo Borah, Rachel M. Wheatley, Jason J. Terpolilli, Gerhard Saalbach, Nick Crang, Daan H. de Groot, R. George Ratcliffe, Nicholas J. Kruger, 
Antonis Papachristodoulou, Philip S. Poole: "Legume control of nitrogen fixation by root nodule bacteria" (*submitted*)  

*eeFBA_O2Var.m*: script for ensemble-evolutionary flux balance analysis with varying oxygen uptake rates; functions are based on the scripts used in [Damiani *et al.*, *PLoS Comput Biol* 2017 Sep 28;13(9):e1005758](https://doi.org/10.1371/journal.pcbi.1005758)  
*NH4assimilation_MalSucr.m*: script for calculating minimum oxygen uptake for bacteroids using malate or sucrose as a carbon source; testing the effect of ammonia assimilation via GS-GOGAT  
*yield_MalSucr.m*: script for calculating maximum nitrogenase activity of bacteroids using malate or sucrose as a carbon source  

## ecmtool
Forked from
```
https://github.com/SystemsBioinformatics/ecmtool.git
```

**bacteroid_aminoacids.py**: extension of main.py to run conversion mode analysis on
*i*CS323, using one amino acid at a time as an input

**ECM_iCC541**: MATLAB script to modify *i*CC541 ([Contador *et al.*, 2020](https://msystems.asm.org/content/5/1/e00516-19)) for conversion mode analysis

### ECMinputs
Excel files specifying inputs and ouputs for conversion mode analysis

### ECMresults
csv files with the conversion modes calculated for the different amino acid inputs

### models_bacteroid
sbml files of the models used for conversion mode analysis

## MatlabScripts
### eeFBA
functions to perform ensemble-evolutionary flux balance analysis; based on scripts developed in [Damiani *et al.* 2017](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1005758)

### helper
functions to perform flux balance analysis-based computations
