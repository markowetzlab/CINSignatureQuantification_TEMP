#' @rdname getsampleByComponent-methods
#' @aliases getsampleByComponent
setMethod("getsampleByComponent",signature = "cignaturesCN",function(object){
        object@featFitting$sampleByComponent
})
