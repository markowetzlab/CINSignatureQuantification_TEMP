#' @rdname getSamples-methods
#' @aliases getSamples
setMethod("getSamples",signature = "cignaturesCN",function(object){
    rownames(object@samplefeatData)
})
