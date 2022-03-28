## Testing ground for package and functions

library(CINSignatureQuantification)

dfTest = readRDS("data/TCGA_478_Samples_SNP6_GOLD.rds")

# Convert to cignatures object
myData = createCignatures(data = dfTest,experimentName = "newExperiment")

## Functions already implemented
# Handling and accessing
getExperiment(myData)
getSamples(myData)
head(getSegments(myData))
myData[1:10]
# Analysing
getSamplefeatures(myData)
# Extending - no additional data available
# myData2 = addsampleFeatures(object = myData,sample.data = <newData>,id.col = "sample")


## Feature extraction (includes smoothing and preparing data)
myData = calculateFeatures(myData, method="drews")

## Get sum-of-posterior matrix
myData = calculateSampleByComponentMatrix(myData, method="drews")

## Get activities
myData = calculateActivity(myData, method="drews")


## Load manually calculated activities for the 478 TCGA/PCAWG samples
compareAct = readRDS("~/Drews2022_CIN_Compendium/Section 5 Robustness analysis/Section 5.2 Signature stability across genomic technologies/input/Activities/4_TCGA_PCAWG_Exposures_to_TCGA_Signatures.rds")
identical(compareAct, myData@activities$normAct1)

## Load TCGA copy number profiles and compare to
cnTCGA = readRDS("~/Downloads/combined.ascat.segments.smoothednormals.rds")
cigTCGA = createCignatures(data = cnTCGA,experimentName = "TCGA")
cigTCGA = calculateFeatures(cigTCGA, method="drews")
cigTCGA = calculateSampleByComponentMatrix(cigTCGA, method="drews")
cigTCGA = calculateActivity(cigTCGA, method="drews")

compareActTCGA = readRDS("~/CINsignatures/1_our_data/Signature_Compendium_v5_Cosine-0.74_Activities_THRESH95_NAMESAPRIL21.rds")
# Probably FALSE because something in R has changed - minuscule changes
identical(rownames(compareAct), rownames(myData@activities$normAct1))
summary(new- compareActTCGA)


sigAct478 = quantifyCNSignatures(dfTest, experimentName = "478TCGAPCAWG", method = "drews")


## Test clinical classifier (CX3/CX2 and De-novo for two self chosen signatures)
vPredPlat = clinPredictionPlatinum(sigAct478)
vPredCX8CX9 = clinPredictionDenovo(sigAct478, sampTrain = sample(getSamples(sigAct478), 50), sigsTrain = c("CX9", "CX8"))

