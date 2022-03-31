#' @rdname calculateSampleByComponentMatrix-methods
#' @aliases calculateSampleByComponentMatrix
setMethod("calculateSampleByComponentMatrix",
          signature=c(object="cignaturesCN"),
          definition=function(object, method=NULL,test.new=FALSE){
              if(is.null(method)){
                method <- getExperiment(object)@feature.method
              }
              switch(method,
                     mac={
                         if(test.new){
                             sxc <- calculateSampleByComponentMatrixMacNEW(object@featData, UNINFPRIOR = TRUE)
                             sxc = c(sxc, method = method)
                         } else {
                         sxc <- calculateSampleByComponentMatrixMac(object@featData,
                                   all_components=NULL,
                                   cores = 1,
                                   rowIter = 1000,
                                   subcores = 2,
                                   method = method)
                         }
                         methods::new("cignaturesCN",object,featFitting=sxc,
                                      ExpData = methods::initialize(object@ExpData,
                                                                    last.modified = as.character(Sys.time()),
                                                                    feature.method = method))
                     },
                     drews={
                         lSxC = calculateSampleByComponentMatrixDrews(object@featData, UNINFPRIOR = TRUE)
                         lSxC = c(lSxC, method = method)
                         methods::new("cignaturesCN",object,featFitting=lSxC,
                                      ExpData = methods::initialize(object@ExpData,
                                                                    last.modified = as.character(Sys.time()),
                                                                    feature.method = method))
                     })

          })
