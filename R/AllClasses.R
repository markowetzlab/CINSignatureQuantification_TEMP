#' cignaturesExpData object
#'
#' @slot experimentName character
#' @slot init.date character
#' @slot last.modified character
#' @slot samples.full numeric
#' @slot samples.current numeric
#' @slot build character
#' @slot feature.method character
#'
#' @export
cignaturesExpData <- setClass("cignaturesExpData",
                    slots = list(experimentName = "character",
                                 init.date = "character",
                                 last.modified = "character",
                                 samples.full = "numeric",
                                 samples.current = "numeric",
                                 build = "character",
                                 feature.method = "character"
                    ),
                    prototype = list(experimentName = NULL,
                                     init.date = as.character(Sys.time()),
                                     last.modified = "NA",
                                     samples.full = NULL,
                                     samples.current = NULL,
                                     build="hg19",
                                     feature.method = "NA")
)


#' cignaturesCN object
#'
#' @slot segments list
#' @slot featData list
#' @slot featFitting list
#' @slot samplefeatData data.frame
#' @slot ExpData cignaturesExpData
#'
#' @export
#'
cignaturesCN <- setClass("cignaturesCN",
                    slots = list(segments = "list",
                                 featData = "list",
                                 featFitting = "list",
                                 samplefeatData = "data.frame",
                                 ExpData = "cignaturesExpData")
)

#' cignaturesSIG
#'
#' @slot activities list
#' @slot signature.model character
#' @slot backup.signatures matrix
#' @slot backup.thresholds numeric
#' @slot backup.scale list
#' @slot backup.scale.model character
#'
#' @export
#'
cignaturesSIG <- setClass("cignaturesSIG",
                              contains = "cignaturesCN",
                              slots = list(
                                  activities = "list",
                                  signature.model = "character",
                                  backup.signatures = "matrix",
                                  backup.thresholds = "numeric",
                                  backup.scale = "list",
                                  backup.scale.model = "character"
                              )
)
