% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Connect.R
\name{Connect}
\alias{Connect}
\title{Connect to a single-cell HDF5 dataset}
\usage{
Connect(filename, type = NULL, mode = c("r", "r+"), force = FALSE)
}
\arguments{
\item{filename}{Name of on-disk file}

\item{type}{Type of single-cell dataset to connect as; choose from:
\itemize{
 \item h5seurat
}
Leave as \code{NULL} to guess type from file extension}

\item{mode}{Mode to connect to data as; choose from:
\describe{
 \item{r}{Open existing dataset in read-only mode}
 \item{r+}{Open existing dataset in read/write mode}
}}

\item{force}{Force a connection if validation steps fail; returns a
\code{\link[hdf5r]{H5File}} object}
}
\value{
An object of class \code{type}, opened in mode \code{mode}
}
\description{
Connect to a single-cell HDF5 dataset
}
