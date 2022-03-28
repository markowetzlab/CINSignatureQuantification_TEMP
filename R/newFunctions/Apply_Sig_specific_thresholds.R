### Script to apply signature-specific thresholds

rm(list=ls(all=TRUE))
library(data.table)

# Ubuntu
# BASE="/Users/drews01/phd/prjcts/cnsigs2"
# Mac
BASE="/Users/drews01/cnsigs2"
EXP=file.path(BASE, "results/Signature_Compendium_v5_Cosine-0.74_Exposures_newNames.rds")
RAW=file.path(BASE, "results/Signature_Compendium_v5_Cosine-0.74_Exposures_newNames_raw.rds")
FILETHRESH=file.path(BASE, "../cnsigs2_revisions/MC_simulation_overfitting/3_Boxplots_per_sig_fullTCGA_1000sims_10pGaussian_10pSamplePoisson.txt")
OUT=file.path(BASE, "results/Signature_Compendium_v5_Cosine-0.74_Exposures_newNames_THRESH95.rds")
OUTRAW=file.path(BASE, "results/Signature_Compendium_v5_Cosine-0.74_Exposures_newNames_raw_THRESH95.rds")


## Load data
exp = readRDS(EXP)
raw = readRDS(RAW)

sigThresh = fread(FILETHRESH)
vThresh = sigThresh$Thresh_ZeroGMM_0.05
names(vThresh) = sigThresh$Sig

allSigs = sigThresh$Sig
for(thisSig in allSigs) {
  
  print(paste("Signature:", thisSig))
  thisThresh = vThresh[ names(vThresh) == thisSig ]
  
  print(paste("Threshold:", thisThresh))
  setZero = exp[, thisSig] < thisThresh
  
  print(paste("Num zero samples before thresholding:", sum(exp[,thisSig]==0)))
  exp[setZero,thisSig] = 0
  print(paste("Num zero samples after thresholding:", sum(exp[,thisSig]==0)))
}

saveRDS(exp, OUT)

## For raw exposures
identical(rownames(raw), rownames(exp))
identical(colnames(raw), colnames(exp))

allSigs = sigThresh$Sig
for(thisSig in allSigs) {
  setZero = exp[, thisSig] == 0
  raw[setZero,thisSig] = 0
}

saveRDS(raw, OUTRAW)
