setMethod("quantifyCNSignatures",
          signature=c(object=c("data.frame")),
          definition=function(object, experimentName="Default", method="drews"){
              # Check method
              if(is.null(method) | ! (method %in% c("drews", "mac")) ){
                  warning("Method was neither 'drews' nor 'mac'. Set it to default 'drews'.")
                  method = "drews"
              }
              switch(method,
                     mac={},
                     drews={
                         # Create object from CN profiles
                         # TODO: Extend for QDNAseq
                         cigTCGA = createCignatures(data = object, experimentName = experimentName)
                         # Extract features
                         cigTCGA = calculateFeatures(cigTCGA, method=method)
                         # Calculate sum-of-posterior matrix
                         cigTCGA = calculateSampleByComponentMatrix(cigTCGA, method=method)
                         # Calculate signature activities
                         cigTCGA = calculateActivity(cigTCGA, method=method)
                         return(cigTCGA)
                     })
              })
