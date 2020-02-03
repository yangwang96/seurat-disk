#' A disk-based object for single-cell analysis
#'
#' @docType class
#' @name scdisk-class
#' @rdname scdisk-class
#' @aliases scdisk
#' @format An \code{\link[R6]{R6Class}} object
#' @seealso \code{\link[hdf5r]{H5File}}
#'
#' @importFrom R6 R6Class
#' @importFrom hdf5r H5File
#'
#' @export
#'
scdisk <- R6Class(
  classname = 'scdisk',
  inherit = H5File,
  cloneable = FALSE,
  portable = TRUE,
  lock_class = TRUE,
  public = list(
    # Methods
    #' @description Create a new \code{scdisk} object
    #' @param filename Name of on-disk file to connect to
    #' @param mode How to open the file
    #' @param validate Validate the file upon connection
    #' @param ... Extra arguments passed to validation routine
    initialize = function(
      filename = NULL,
      mode = c('a', 'r', 'r+', 'w', 'w-', 'x'),
      validate = TRUE,
      ...
      ) {
      mode <- match.arg(arg = mode)
      if (!file.exists(filename) && !mode %in% c('a', 'w', 'w-', 'x')) {
        stop("Cannot find file ", filename, call. = FALSE)
        }
      super$initialize(filename = filename, mode = mode)
      private$validate(validate = validate, ...)
    },
    #' @description Handle the loss of reference to this \code{scdisk} object
    finalizer = function() {
      self$close_all(close_self = TRUE)
    }
  ),
  private = list(
    # Methods
    # @description Prebuilt error messages to reduce code duplication
    # @param type Type of error message to produce, choose from
    # \describe{
    #  \item{mode}{Cannot modify a file that has been opened as read-only}
    #  \item{ambiguous}{Unable to uniquely locate a dataset}
    # }
    # @return A character vector with the error message requested
    # @keywords internal
    errors = function(type = c('mode', 'ambiguous')) {
      type <- match.arg(arg = type)
      return(switch(
        EXPR = type,
        'mode' = paste('Cannot modify a', class(x = self)[1], 'file in read-only mode'),
        'ambiguous' = 'Cannot identify the dataset provided, found too many like it; please be more specific'
      ))
    },
    # @description Validate ...
    # @param ... Ignored for \code{scdisk} method
    # @note The validation routine should be overwritten by subclasses of
    # \code{scdisk}; each validation routine must take at least one argument:
    # \code{validate} (a logical). Extra arguments are allowed.
    validate = function(...) {
      if (class(x = self)[1] == 'scdisk') {
        stop("Cannot create an scdisk object directly", call. = FALSE)
      }
      warning(
        "No validation method present for ",
        class(x = self)[1],
        " files",
        call. = FALSE,
        immediate. = TRUE
      )
    }
  )
)