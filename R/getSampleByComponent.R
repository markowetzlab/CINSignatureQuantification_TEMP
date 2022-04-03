#' @rdname getSampleByComponent-methods
#' @aliases getSampleByComponent
setMethod("getSampleByComponent",signature = "cignaturesCN",function(object){
        object@featFitting$sampleByComponent
})
