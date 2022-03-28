setMethod("clinPredictionDenovo",
          signature=c(object="cignaturesSIG"),
          definition=function(object, sampTrain, sigsTrain){
              # Load normalised signature activities
              mNorm = object@activities$normAct1

              # Extract samples for training
              if(is.null(sampTrain)) { stop("No sample names supplied.")}
              if(is.null(sigsTrain)) { stop("No signature names supplied.")}
              if(length(sigsTrain) != 2) { stop("So far only two signatures can be used.")}
              mTrain = mNorm[ rownames(mNorm) %in% sampTrain, colnames(mNorm) %in% sigsTrain]
              mTest = mNorm[ ! rownames(mNorm) %in% sampTrain, colnames(mNorm) %in% sigsTrain]

              # Scale training data and apply to test cohort
              scaledTrain = scale(mTest)
              lModel = list(mean = attr(scaledTrain, "scaled:center"),
                            scale = attr(scaledTrain, "scaled:scale"))

              scaledTest = scaleByModel(mTest, lModel)

              # Do classification
              vPred = ifelse(scaledTest[,sigsTrain[1]] >= scaledTest[,sigsTrain[2]], paste("Signature", sigsTrain[1], "higher"),
                             paste("Signature", sigsTrain[2], "higher"))
              return(vPred)
})
