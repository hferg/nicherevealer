#' reveal_niche
#' Give me a species name and a raster stack of climate data and I will give
#' YOU an estimate of that species cliamtic niche.
#' @name reveal_niche
#' @export

reveal_niche <- function(sp, fit_data, predict_data,
  # options for presence and absence points. This is things like the density 
  # of background points, absences or not, the size of buffer around presence
  # points for absence sampling. This will also include options for the
  # how to sample background points - i.e. use the whole extent of the study 
  # region, or provide a mask.
  points_control = list(),
  # this will have options for the maps - i.e. projection, extent of space to
  # model.
  geo_control = list(),
  # options for the SDM portion of the model. One obvious inclusion here is
  # the models that are to be fitted.
  sdm_control = list(),
  # control options for evaluation. This will be kfolds, threshold(s) to use,
  # ... just those two things?
  eval_control = list(),
  # control how the ensemble model is constructed. This will include weighting
  # options, method of combination, that sort of thing.
  ensemble_control = list()
  # options for parallelisation - default to no parallelisation, but will
  # include the number of threads, and options to parallelise each of the main
  # steps of the function - I think?
  parallel_control = list()
  # this will be options for the outputs - what filename prefix to use, save
  # pdfs, pngs of maps etc., save intermediate model files and so on and so
  # forth.
  output_control = list()
  ) {

# step by step.

# 0) sort out the control lists.
  points_opts <- list(
    download = TRUE,
    shapefile = FALSE,
    background = TRUE,
    absence = TRUE,
    buffer = 0,
    np_mask = "none"
  )
  points_opts[names(points_control)] <- points_control
  # do some checks here for mutual exclusivity. e.g. if download is TRUE, 
  # then shapefile must be FALSE - warn the user.

  geo_opts <- list(
    projection = "match",
    extent = "estimate"
  )
  geo_opts[names(geo_control)] <- geo_control
  sdm_opts <- list(
    models = c("bioclim", "domain", "glm", "gamm", "randomforest", "svm",
      "mars")
  )
  sdm_opts[names(sdm_control)] <- sdm_control
  eval_opts <- list(
    kfold = 5,
    threshold = "tss"
  )
  eval_opts[names(eval_control)] <- eval_control
  ensemble_opts <- list(
    method = "consensus",
    weighting = TRUE
  ) 
  ensemble_opts[names(ensemble_control)] <- ensemble_control
  parallel_opts <- list(
    n_cores = 1
  )
  parallel_opts[names(parallel_control)] <- parallel_control
  output_opts <- list(
    save_maps = TRUE,
    save_ensemble = TRUE,
    save_points = FALSE,
    maps = c("pdf", "png"),
    save_intermediate = FALSE,
    overwrite = TRUE
  )
  output_opts[names(output_control)] <- output_control


# 1) Deal with species data.
  # 1.1) Check what is given.
  # 1.1.1) if species name, move on to points download.
  # 1.1.2) if not, check to see if file name, and if that file exists. If it 
  #   does, load it up. If it doesn't, stop with descriptive error.
  # 1.1.3) Check class of points object to find out what it is.


  # Find out what sp is.
  if (points_opts$download) {
    # download species data from GBIF.
    sp <- data_download_function(sp, other, arguments)
  } else {
    # If download is false, then we assume that "sp" is either a filename
    # or an object containing data.
    # if it is a filename it will be of class character.
    if (class(sp) == "character") {
      # check that the file exists.
      if (file.exists(sp)) {
        sp <- open_sp(sp, points_opts$shapefile)
      } else {
        stop("sp file does not exist.")
      }
    }
    # now sp is either read in, or was already an object with a class.
    # identify the class. If the class is data.frame or matrix then it
    # needs to be converted into a spatialpoints object and assigned a
    # proj4string. If no projection is specified, then assume lat lon,
    # and assign the latlon proj4string whilst catting a warning to the 
    # screen.
    # if the class is polygon then it means points need to be sampled from
    # within the polygon specified - there is code for this in the sdmpl
    # package.
    if (class(sp) == "SpatialPolygonsDataFrame") {
      
    } else if (class(sp) == "data.frame" | class(sp) == "matrix") {
      # column names can either be "x y" or "lat lon" or "lat long" or
      # "latitude longitude". Find out which it is, and the order so that
      # the coordinate setting works properly.
      coord_cols <- check_coord_cols(sp)
      # If it's none of the above then check that there are only two columns.
      # If there are then assume that the first is x, the second is y, and 
      # cat a warning to the screen.

      # If none of the above error and stop.
    } else if (class(sp) == "SpatialPoints" | 
      class(sp) == "SpatialPointsDataFrame") {

    }
  }


}

