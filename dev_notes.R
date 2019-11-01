# this package is for use with the SA SDM project, but will also be a useful
# SDM framework in general, especially for processing a large number of species

# package motivation.
# 1) have a single function that will take (as minimum arguments) a species
#   name and some climate data and return a sensible ensemble model.
#     if these minimum arguments are given then an extent needs to be assumed,
#     and the projection is fixed to the standard latlon projection.
#     data will come from gbif in this example.
#     Optional extras:
#       future climate for prediction
#       a tonne of control parameters (these can and should be delivered in 
#       lists - see BTprocessR functions for how this is working and so on.)
# 2) Each component of this ought to be able to be run as a sub-step. e.g.
#   get the species data, fit the model to data rather than download the data
#   and so on.
# 3) in order for this to be sensible for a TONNE of species it doesn't make
#   sense for the function to go over and over since it will take forever.
#   Thus there ought to be a set of functions to take a vector of species names,
#   and then generate a folder ready for transferance to legion. This will 
#   contain the necessary climate data, the necessary species data, and then
#   a series of analysis script and job scripts, and a bash script that will
#   submit all of those job scripts.


# Presence points methods.
#   Points can come in a few different forms.
#     matrix with column headings
#     matrix without column headings
#     data frame with column headings
#     data frame without column headings
#     spatialpoints/spatialpointsdataframe object
#     a shapefile of a species range
#     a species name - download from gbif.
#       in this case the data need cleaning.
#     ?? a filename - is this doable? If it's a filename, work out how to
#       read the file in and then deal with whatever it is??
# These could all be handled with a single function with different methods,
#   depending on the class of the data coming in. The classes could be...

