checkChromosomeFormat <- function(x){
    x.uni <- unique(x)
    if(base::any(base::grepl(x = x.uni,pattern = "chr*",perl = T))){
        x <- as.character(base::gsub(x = x,pattern = "chr",replacement = ""))
    }
    x.uni <- unique(x)
    if(any(x.uni %in% c("23","24"))){
        x[x == "23"] <- "X"
        x[x == "24"] <- "Y"
    }
    x.uni <- unique(x)
    if(!all(x.uni %in% as.character(c(1:22,"X","Y")))){
        id <- which(!any(x.uni %in% as.character(c(1:22,"X","Y"))))
        stop(paste0("Unknown chromosome identifier present ",x.uni[id]))
    }
    return(as.factor(x))
}
