#' @rdname getSampleByComponent-methods
#' @aliases getsampleByComponent
setMethod("getSampleByComponent",signature = "cignaturesCN",function(object){
        object@featFitting$sampleByComponent
})
