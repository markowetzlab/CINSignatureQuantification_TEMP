getCores = function() {
    tempCores = detectCores()
    CORES = ifelse(tempCores < 3, 1, tempCores-1)
    return(CORES)
}
