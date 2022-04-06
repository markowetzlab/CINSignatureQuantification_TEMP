applyThreshNormAndScaling = function(Hraw) {

    # Normalise matrix
    H = t( apply(Hraw, 2, function(x) x/sum(x)) )

    # Apply signature-specific thresholds (no renormalising happening in order to avoid inflation of signal)
    vThresh = get(load("data/Drews2022_TCGA_Signature_Thresholds.rda"))
    threshH = sapply(names(vThresh), function(thisSig) {

        sigVals = H[,thisSig]
        sigVals[ sigVals < vThresh[thisSig] ] = 0

        return(sigVals)
    })

    # Scale according to TCGA-specific scaling factors
    lScales = get(load("data/Drews2022_TCGA_Scaling_Variables.rda"))
    threshScaledH = scaleByModel(threshH, lScales)

    # Combine for return
    lOut = list(rawAct0 = t(Hraw), normAct1 = H, thresholdAct2 = threshH, scaledAct3 = threshScaledH)
    return(lOut)
}
