#' @rdname calculateFeatures-methods
#' @aliases calculateFeatures
#' @importFrom data.table rbindlist
#' @importFrom parallel getCores
setMethod("calculateFeatures",
          signature=c(object="cignaturesCN"),
          definition=function(object,method = NULL,smooth.diploid=TRUE){
              methods <- c("mac","drews")
              if(is.null(method)){
                  stop("no method provided")
              } else if(!method %in% methods){
                  stop("unknown method")
              }
              switch(method,
                mac={
                    featData <- extractCopynumberFeaturesMac(object@segments)
                    methods::initialize(object,featData=featData,
                           ExpData = methods::initialize(object@ExpData,
                                                         last.modified = as.character(Sys.time()),
                                                         feature.method = method))
                },
                drews={
                    # Set number of cores
                    CORES = getCores()
                    # Smooth and merge segments
                    smoothed = smoothAndMergeSegments(getSegments(object), CORES, WIGGLE = 0.1, colNameSegVal = "segVal", colNameChr = "chromosome", IGNOREDELS = FALSE)
                    # Avoid measurement errors
                    smoothed = avoidMeasurementErrors(smoothed)
                    # Filter samples without CIN
                    filtered = removeQuietSamples(smoothed, DCIN = 20)
                    # Extract
                    featData = startCopynumberFeatureExtractionDrews(filtered, CORES = CORES, RMNORM = TRUE)
                    methods::initialize(object,featData=featData,
                                        ExpData = methods::initialize(object@ExpData,
                                                                      last.modified = as.character(Sys.time()),
                                                                      feature.method = method))

                })
          })
