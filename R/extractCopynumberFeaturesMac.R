extractCopynumberFeaturesMac <- function(CN_data,cores = 1){
    #chrlen <- get(load("data/hg19.chrom.sizes.rda"))
    chrlen <- get(data("hg19.chrom.sizes",envir = environment()))
    #gaps <- get(load("data/gap_hg19.rda"))
    gaps <- get(data("gap_hg19.rda",envir = environment()))
    centromeres <- gaps[gaps[,8]=="centromere",]
    if(cores > 1) {
        if (!requireNamespace("doParallel", quietly = TRUE)) {
            stop(
                "Package \"doParallel\" must be installed to use multiple threads/cores.",
                call. = FALSE
            )
        }
        # Multi-core usage
        `%dopar%` <- foreach::`%dopar%`
        doParallel::registerDoParallel(cores)
        i <- NULL
        temp_list = foreach::foreach(i=1:6) %dopar% {
            if(i == 1){
                list(segsize = getSegsize(CN_data) )
            } else if (i == 2) {
                list(bp10MB = getBPnum(CN_data,chrlen) )
            } else if (i == 3) {
                list(osCN = getOscillation(CN_data,chrlen) )
            } else if (i == 4) {
                list(bpchrarm = getCentromereDistCounts(CN_data,centromeres,chrlen) )
            } else if (i == 5) {
                list(changepoint = getChangepointCN(CN_data) )
            } else {
                list(copynumber = getCN(CN_data) )
            }

        }
        doParallel::stopImplicitCluster()
        unlist( temp_list, recursive = FALSE )
    } else {
        segsize <- getSegsize(CN_data)
        bp10MB <- getBPnum(CN_data,chrlen)
        osCN <- getOscillation(CN_data,chrlen)
        bpchrarm <- getCentromereDistCounts(CN_data,centromeres,chrlen)
        changepoint <- getChangepointCN(CN_data)
        copynumber <- getCN(CN_data)

        list(segsize=segsize,
             bp10MB=bp10MB,
             osCN=osCN,
             bpchrarm=bpchrarm,
             changepoint=changepoint,
             copynumber=copynumber)
    }
}
