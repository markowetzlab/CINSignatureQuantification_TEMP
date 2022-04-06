#' @importFrom YAPSA LCD
calculateActivityDrews = function(myData) {

    # Extract relevant information from object
    V = myData@featFitting$sampleByComponent
    nSamp = length(getSamples(myData))
    nFeat = ncol(myData@featFitting$sampleByComponent)

    # Load signatures
    W = get(load("data/Drews2022_TCGA_Signatures.rda"))

    # Sanity check mutational catalogue (not really necessary)
    if(nSamp > nFeat) {
        # Case 1: More samples than features
        if(nrow(V) > ncol(V)) { V = t(V) }
    } else if(nSamp < nFeat) {
        # Case 2: Fewer samples than features
        if(nrow(V) < ncol(V)) { V = t(V) }
    } else {
        # Case 3: Edge case where there are as many samples as features
        if(sum(grepl("segsize", colnames(V))) > 0) { V = t(V) }
    }


    # Sanity check signature matrix
    if(nrow(W) < ncol(W)) W = t(W)
    # Check order of components and fix if necessary
    if(! identical(rownames(W), rownames(V)) ) {
        W = W[ match(rownames(V), rownames(W)), ]
    }

    ### YAPSA needs:
    ## Full matrix V        mutCatalogue        components (rows) by samples (cols)    <= HAVE
    ## Left matrix W        sigCatalogue        components (rows) by signature (cols)   <= HAVE
    ## Right matrix H       expCatalogue        signature (rows) by samples (cols)     <= WANT

    # in_mutation_catalogue_df => NxM => N - Features, M - Samples => Component by Sample matrix
    # in_signatures_df => NxL => N - Features, L - Signatures => Component by Signature matrix
    Hraw = as.matrix( LCD( in_mutation_catalogue_df = V, in_signatures_df = W, in_per_sample_cutoff = 0 ) )
    return(Hraw)

}
