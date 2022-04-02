#' @rdname calculateSampleByComponentMatrix-methods
#' @aliases calculateSampleByComponentMatrix
setMethod("calculateSampleByComponentMatrix",
          signature=c(object="cignaturesCN"),
          definition=function(object, method=NULL){
              if(is.null(method)){
                method <- getExperiment(object)@feature.method
              }
              switch(method,
                     mac={
                         sxc <- calculateSampleByComponentMatrixMac(object@featData,
                                                                      UNINFPRIOR = FALSE)
                         sxc = c(sxc, method = method)
                         methods::new("cignaturesCN",object,featFitting=sxc,
                                      ExpData = methods::initialize(object@ExpData,
                                                                    last.modified = as.character(Sys.time()),
                                                                    feature.method = method))
                     },
                     drews={
                         lSxC = calculateSampleByComponentMatrixDrews(object@featData,
                                                                     UNINFPRIOR = TRUE)
                         lSxC = c(lSxC, method = method)
                         methods::new("cignaturesCN",object,featFitting=lSxC,
                                      ExpData = methods::initialize(object@ExpData,
                                                                    last.modified = as.character(Sys.time()),
                                                                    feature.method = method))
                     })

          })
