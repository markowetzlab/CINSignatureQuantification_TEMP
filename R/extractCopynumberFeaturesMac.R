extractCopynumberFeaturesMac <- function(CN_data){
    chrlen <- get(load("data/hg19.chrom.sizes.rda"))
    gaps <- get(load("data/gap_hg19.rda"))
    centromeres <- gaps[gaps[,8]=="centromere",]
    segsize <- getSegsize(CN_data)
    bp10MB <- getBPnum(CN_data,chrlen)
    osCN <- getOscilation(CN_data,chrlen)
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
