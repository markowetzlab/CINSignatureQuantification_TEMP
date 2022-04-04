#' plotActivities
#'
#' Plot the copy number signature activites for a given cignatures class object
#' containing copy number signature activities/exposures.
#'
#' @param object A cignatureSIG class object
#'
#' @return plot
#' @export plotActivities
#'
plotActivities <- function(object){
    if(is.null(object)){
        stop("No object provided, object should be a object of class cignaturesCN or cignaturesSIG")
    }
    if(!class(object) == "cignaturesSIG"){
        stop("Object is not of class cignaturesSIG")
    }
    ## May need to change which matrix is used
    if(object@signature.model == "drews"){
        plotdata <- object@activities$thresholdAct2
        cols <- c("grey50")
        clms <- 5
    } else {
        plotdata <- object@activities$normAct1
        cols <- c("#1B9E77","#D95F02","#7570B3","#E7298A",
                  "#66A61E","#E6AB02","#A6761D")
        clms <- 3
    }

    plotdata <- plotdata[order(plotdata[,1],decreasing = T),]
    tabl <- t(as.matrix(plotdata))
    #tabl <- tabl[,order(ncol(tabl):1)]

    barplot(tabl,
            main = paste0("Signature activities (","method: ",object@signature.model,")"),
            col = cols,
            xlab = "sample",
            names.arg=rep("",ncol(tabl)),
            ylab = "relative exposure",
            axes=TRUE)
    legend(x = "bottomright",
           legend = rownames(tabl),
           fill=cols,
           cex=0.7,
           ncol=clms,
           box.col=NA)
}
