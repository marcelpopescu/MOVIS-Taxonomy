These Octave scripts and functions are used to classify the objects reported in MOVIS-C data

For an individual object, use:
    ReportTaxonomyMOVISCobj(<asteroid number>). Example:ReportTaxonomyMOVISCobj('5587')
It reports the probabilities for each class, as described in Popescu et al 2018
and the position in the Y-J versus J-Ks color space

The entire file can be run  using ClassifyMOVIS.m script. This takes ~6hrs

The scripts were tested using Octave 4.2.1, https://octave.sourceforge.io/

