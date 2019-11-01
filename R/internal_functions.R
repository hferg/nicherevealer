open_sp <- function(sp, shapefile) {
  if (shapefile) {
    # sort this out later on...
    # trycatch()
  } else {
    ext <- strsplit(sp, "\\.")[[1]]
    ext <- ext[length(ext)]  
    if (ext == "RDS") {
      sp <- readRDS(sp)
    } else if (ext == "csv") {
      sp <- read.csv(sp)
    } else if (ext == "txt") {
      sp <- read.table(sp)
    } else if (ext == "xls" | ext == "xlsx") {
      stop(paste("please convert", ext, "file into comma-delimited (.csv)"))
    } else {
      stop("file format not supported - please use comma-delimited (.csv) or
        tab-delimited (with .txt extension) for tables. For R objects please
        use the saveRDS function with the .RDS extension to generate the
        file.")
    }
  }
  return(sp)
}

check_coord_cols <- function(sp) {
  if (all(c("x", "y") %in% colnames(sp))) {
    coord_cols <- c("x", "y")
  } else if (all(c("lat", "lon") %in% colnames(sp))) {
    coord_cols <- c("lat", "lon")
  } else if (all(c("lat", "long") %in% colnames(sp))) {
    coord_cols <- c("lat", "long")
  } else if (all(c("lati", "longi") %in% colnames(sp))) {
    coord_cols <- c("lati", "longi")
  } else if (all(c("latitude", "longitude") %in% colnames(sp))) {
    coord_cols <- c("latitude", "longitude")
  } else {
    if (ncol(sp) == 2) {
      coord_cols <- colnames(sp)
      warning("Column names of sp are unexpected - assuming the first column 
        is latitude and the second is longitude.")
    } else {
      stop("Cannot find coordinates in sp. Columns for coordinates should be 
        labelled one of:
        'x' and 'y',
        'lat' and 'lon',
        'lat' and 'long',
        'lati' and 'longi' or
        'latitude' and 'longitude'.")
    }
  }
  return(coord_cols)
}