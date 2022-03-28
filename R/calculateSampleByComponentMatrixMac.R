gSByC_MAC <- function(CN_features, all_components=NULL, cores = 1, rowIter = 1000, subcores = 2, method=method)
{
    if(is.null(all_components))
    {
        # This file is large and should be reimplemented in some form - Specifically only retain data flexmix::posterior requires for SoP?
        all_components<-get(load("data/mac_component_parameters.rda"))
    }
    # if(cores > 1){
    #     require(foreach)
    #     feats = c( "segsize", "bp10MB", "osCN", "changepoint", "copynumber", "bpchrarm" )
    #     doMC::registerDoMC(cores)
    #     full_mat = foreach(feat=feats, .combine=cbind) %dopar% {
    #         calculateSumOfPosteriors_MAC(CN_features[[feat]],all_components[[feat]],
    #                                  feat, rowIter = rowIter, cores = subcores)
    #     }
    # } else {
    full_mat<-cbind(
        calculateSumOfPosteriors_MAC(CN_features[["segsize"]],all_components[["segsize"]],"segsize"),
        calculateSumOfPosteriors_MAC(CN_features[["bp10MB"]],all_components[["bp10MB"]],"bp10MB"),
        calculateSumOfPosteriors_MAC(CN_features[["osCN"]],all_components[["osCN"]],"osCN"),
        calculateSumOfPosteriors_MAC(CN_features[["changepoint"]],all_components[["changepoint"]],"changepoint"),
        calculateSumOfPosteriors_MAC(CN_features[["copynumber"]],all_components[["copynumber"]],"copynumber"),
        calculateSumOfPosteriors_MAC(CN_features[["bpchrarm"]],all_components[["bpchrarm"]],"bpchrarm"))
    #}
    rownames(full_mat)<-unique(CN_features[["segsize"]][,1])
    full_mat[is.na(full_mat)]<-0
    list(method=method,sampleByComponent=full_mat,model=all_components)
}

calculateSumOfPosteriors_MAC<-function(CN_feature,components,name, rowIter = 1000, cores = 1)
{
    # if(cores > 1){
    #     require(foreach)
    #     require(doMC)
    #     len = dim(CN_feature)[1]
    #     iters = floor( len / rowIter )
    #     lastiter = iters[length(iters)]
    #     registerDoMC(cores)
    #     curr_posterior = foreach( i=0:iters, .combine=rbind) %dopar% {
    #         start = i*rowIter+1
    #         if(i != lastiter) { end = (i+1)*rowIter } else { end = len }
    #         flexmix::posterior(components,data.frame(dat=as.numeric(CN_feature[start:end,2])))
    #     }
    # } else {
    curr_posterior<-flexmix::posterior(components,data.frame(dat=as.numeric(CN_feature[,2])))
    #}
    mat<-cbind(CN_feature,curr_posterior)
    posterior_sum<-c()
    ## foreach and parallelising doesn't make the following code faster.
    for(i in unique(mat$ID))
    {
        posterior_sum<-rbind(posterior_sum,colSums(mat[mat$ID==i,c(-1,-2)]))
    }
    params<-flexmix::parameters(components)
    if(!is.null(nrow(params)))
    {
        posterior_sum<-posterior_sum[,order(params[1,])]
    }
    else
    {
        posterior_sum<-posterior_sum[,order(params)]
    }
    colnames(posterior_sum)<-paste0(name,1:ncol(posterior_sum))
    rownames(posterior_sum)<-rownames(unique(mat$ID))
    posterior_sum
}
