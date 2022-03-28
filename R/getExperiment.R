#' @rdname getExperiment-methods
#' @aliases getExperiment
setMethod("getExperiment",signature = "cignaturesCN",function(object){
    object@ExpData
})
