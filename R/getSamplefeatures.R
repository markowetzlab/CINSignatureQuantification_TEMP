#' @rdname getSamplefeatures-methods
#' @aliases getSamplefeatures
setMethod("getSamplefeatures",signature = "cignaturesCN",function(object){
    object@samplefeatData
})
