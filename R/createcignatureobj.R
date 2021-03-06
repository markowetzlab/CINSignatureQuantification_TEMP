#' createCignatures
#'
#' @param data Unrounded absolute copy number data
#' @param experimentName A name for the experiment (default: defaultExperiment)
#' @param build A genome build specified as either hg19 or hg38 (default: hg19)
#'
#' @return A cignaturesCN class object
#' @export createCignatures
#'
createCignatures <- function(data=NULL,experimentName = "defaultExperiment",build = "hg19"){
    if(is.null(data)){
        stop("no data provided\n")
    }
    if(is.character(data)){
        if(!file.exists(data)){
            stop("File not found\n")
        }
        if(file.exists(data)){
            header <- colnames(data.table::fread(input = data,
                                          header = T,
                                          colClasses = c("character","numeric","numeric","numeric","character"),
                                          nrows = 1))
            if(!any(header == c("chromosome","start","end","segVal","sample"))){
                stop("Header does not match the required naming")
            }
            segTable <- data.table::fread(input = data,
                                   header = T,
                                   colClasses = c("character","numeric","numeric","numeric","character"))
            if(checkSegValRounding(segTable$segVal)){
                warning("segVal appears to be rounded, copy number signatures require unrounded absolute copy numbers")
            }
            if(checkbinned(segTable)){
                #segTable <- getSegTable()
                #
                # Not implemented
                #
                #split(segTable,f = as.factor(segTable$sample))
            } else {
                segTable <- split(segTable,f = as.factor(segTable$sample))
            }
            samplefeatData <- generateSampleFeatData(x = segTable)
            methods::new("cignaturesCN",segments = segTable,samplefeatData = samplefeatData,
                ExpData = methods::new("cignaturesExpData",
                              build = build,
                              samples.full = length(segTable),
                              samples.current = length(segTable),
                              experimentName = experimentName))
        }
    } else if("QDNAseqCopyNumbers" %in% class(data)){
        segTable <- getSegTable(x = data)
        if(checkSegValRounding(segTable$segVal)){
            warning("segVal appears to be rounded, copy number signatures require unrounded absolute copy numbers")
        }
        segTable <- split(segTable,f = as.factor(segTable$sample))
        samplefeatData <- generateSampleFeatData(x = segTable)
        methods::new("cignaturesCN",segments = segTable,samplefeatData = samplefeatData,
                     ExpData = methods::new("cignaturesExpData",
                          build = build,
                          samples.full = length(segTable),
                          samples.current = length(segTable),
                          experimentName = experimentName))
    } else if(is.data.frame(data)){
        header <- colnames(data)
        if(!any(header == c("chromosome","start","end","segVal","sample"))){
            stop("Header does not match the required naming")
        }
        segTable <- data
        if(checkSegValRounding(segTable$segVal)){
            warning("segVal appears to be rounded, copy number signatures require unrounded absolute copy numbers")
        }
        if(checkbinned(segTable)){
            #segTable <- getSegTable()
            #split(segTable,f = as.factor(segTable$sample))
        } else {
            segTable <- split(segTable,f = as.factor(segTable$sample))
        }
        samplefeatData <- generateSampleFeatData(x = segTable)
        methods::new("cignaturesCN",segments=segTable,samplefeatData = samplefeatData,
                     ExpData = methods::new("cignaturesExpData",
                          build = build,
                          samples.full = length(segTable),
                          samples.current = length(segTable)
                          ,experimentName = experimentName))
    } else {
        stop("Unknown input format\n")
    }
}
