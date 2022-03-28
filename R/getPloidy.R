getPloidy<-function(abs_profiles){
    out<-c()
    samps<-names(abs_profiles)
    for(i in samps)
    {
        if(class(abs_profiles)=="QDNAseqCopyNumbers")
        {
            segTab<-getSegTable(abs_profiles[,which(colnames(abs_profiles)==i)])
        }
        else
        {
            segTab<-abs_profiles[[i]]
            colnames(segTab)[4]<-"segVal"
        }
        segLen<-(as.numeric(segTab$end)-as.numeric(segTab$start))
        ploidy<-sum((segLen/sum(segLen))*as.numeric(segTab$segVal))
        out<-c(out,ploidy)
    }
    data.frame(out,stringsAsFactors = F)
}
