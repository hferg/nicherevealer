open_sp <- function(spp, shapefile) {
  if (shapefile) {
    # sort this out later on...
    # trycatch()
  } else {
    ext <- strsplit(spp, "\\.")[[1]]
    ext <- ext[length(ext)]  
    if (ext == "RDS") {
      spp <- readRDS(spp)
    } else if (ext == "csv") {
      spp <- read.csv(spp)
    } else if (ext == "txt") {
      spp <- read.table(spp)
    } else if (ext == "xls" | ext == "xlsx") {
      stop(paste("please convert", ext, "file into comma-delimited (.csv)"))
    } else {
      stop("file format not supported - please use comma-delimited (.csv) or
        tab-delimited (with .txt extension) for tables. For R objects please
        use the saveRDS function with the .RDS extension to generate the
        file.")
    }
  }
  return(spp)
}

check_coord_cols <- function(spp) {
  if (all(c("x", "y") %in% colnames(spp))) {
    coord_cols <- c("x", "y")
  } else if (all(c("lat", "lon") %in% colnames(spp))) {
    coord_cols <- c("lat", "lon")
  } else if (all(c("lat", "long") %in% colnames(spp))) {
    coord_cols <- c("lat", "long")
  } else if (all(c("lati", "longi") %in% colnames(spp))) {
    coord_cols <- c("lati", "longi")
  } else if (all(c("latitude", "longitude") %in% colnames(spp))) {
    coord_cols <- c("latitude", "longitude")
  } else {
    if (ncol(spp) == 2) {
      coord_cols <- colnames(spp)
      warning("Column names of spp are unexpected - assuming the first column 
        is latitude and the second is longitude.")
    } else {
      stop("Cannot find coordinates in spp Columns for coordinates should be 
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