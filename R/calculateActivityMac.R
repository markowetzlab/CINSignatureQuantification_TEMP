#' @importFrom YAPSA LCD
calculateActivityMac <- function(object){

        sample_by_component<-object@featFitting$sampleByComponent
        component_by_signature<-get(load("data/Macintyre2018_OV_Signatures.rda"))

        signature_by_sample<-LCD(t(sample_by_component),YAPSA::normalize_df_per_dim(component_by_signature,2))
        signature_by_sample<-normaliseMatrix(signature_by_sample)
        signature_by_sample
        return(signature_by_sample)
}


normaliseMatrix<-function(signature_by_sample,sig_thresh=0.01)
{
    norm_const<-colSums(signature_by_sample)
    sample_by_signature<-apply(signature_by_sample,1,function(x){x/norm_const})
    sample_by_signature<-apply(sample_by_signature,1,lower_norm,sig_thresh)
    signature_by_sample<-t(sample_by_signature)
    norm_const<-apply(signature_by_sample,1,sum)
    sample_by_signature<-apply(signature_by_sample,2,function(x){x/norm_const})
    signature_by_sample<-t(sample_by_signature)
    signature_by_sample
}

lower_norm<-function(x,sig_thresh=0.01)
{
    new_x<-x
    for(i in 1:length(x))
    {
        if(x[i]<sig_thresh)
        {
            new_x[i]<-0
        }
    }
    new_x
}
