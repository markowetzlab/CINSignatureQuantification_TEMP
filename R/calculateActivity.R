#' @rdname calculateActivity-methods
#' @aliases calculateActivity
setMethod("calculateActivity",
          signature=c(object="cignaturesCN"),
          definition=function(object, method="drews"){
              # Check method
              if(is.null(method)){
                  method <- getExperiment(object)@feature.method
              }
              switch(method,
                     mac={},
                     drews={
                         # Calculate activities
                         Hraw = calculateActivityDrews(object)
                         # Apply thresholds, normalisation and TCGA-specific scaling
                         lSigs = applyThreshNormAndScaling(Hraw)

                         # Load data to be put into model as backup
                         W = get(load("data/Drews2022_TCGA_Signatures.rda"))
                         vThresh = get(load("data/Drews2022_TCGA_Signature_Thresholds.rda"))
                         lScales = get(load("data/Drews2022_TCGA_Scaling_Variables.rda"))

                         # Combine results
                         methods::new("cignaturesSIG",object,
                                      activities=lSigs,
                                      signature.model = method,
                                      backup.signatures=W,
                                      backup.thresholds=vThresh,
                                      backup.scale=lScales,
                                      backup.scale.model="TCGA",
                                      ExpData = methods::initialize(object@ExpData,
                                                                    last.modified = as.character(Sys.time()),
                                                                    feature.method = method))

                     })
              })
