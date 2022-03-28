startCopynumberFeatureExtractionDrews = function(dtSmooth, CORES = 1, RMNORM = TRUE) {

    # Convert to data frame
    dfBR = data.frame(dtSmooth)
    # Split by sample
    lBR = split( dfBR, dfBR$sample )
    # Extract features
    brECNF = extractCopynumberFeaturesDrews(lBR, cores = CORES, rmNorm = RMNORM)

    return(brECNF)
}
