setMethod("clinPredictionPlatinum",
          signature=c(object="cignaturesSIG"),
          definition=function(object){
              # Load normalised signature activities
              mNorm = object@activities$normAct1

              # Load and apply gBRCA1 scaling vars
              lModel = readRDS("data/Drews2022_CX3CX2_Clinical_classifier.rds")
              mNormGBRCA1 = scaleByModel(mNorm[,names(lModel$mean)], lModel)

              # Do classification
              vPred = ifelse(mNormGBRCA1[,"CX3"] >= mNormGBRCA1[,"CX2"], "Predicted sensitive", "Predicted resistant")
              return(vPred)
})
