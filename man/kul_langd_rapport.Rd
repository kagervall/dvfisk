% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/KulLangd.R
\name{kul_langd_rapport}
\alias{kul_langd_rapport}
\title{Return the survey data for the site specified by \code{lan}, \code{lokalId}, \code{fiske} and \code{ar}}
\usage{
kul_langd_rapport(lan, lokalId, fiske, ar)
}
\arguments{
\item{lan}{character, name of the county (län) where  site (lokalId) is located}

\item{lokalId}{character, id of the site (lokalId) to get data for}

\item{fiske}{character, type of survey (fiske) to get data for}

\item{ar}{integer, one or several year (ar) to get data for}
}
\value{
A data.frame (11 columns) with the survey data for the site (lokalId)
}
\description{
Return the survey data for the site specified by \code{lan}, \code{lokalId}, \code{fiske} and \code{ar}
}
\examples{
# This example will access the Internet to get the data and will not work offline
results <- kul_langd_rapport("Blekinge län", 204, "Gåsöfjärden inventering", ar = 2019)
dim(results)
}
\seealso{
Description of
\url{https://www.slu.se/en/departments/aquatic-resources1/databases/database-for-coastal-fish-kul/},
description of API \url{https://dvfisk.slu.se/swagger/index.html}

Other KulLangd API functions: 
\code{\link{kul_langd_ar}()},
\code{\link{kul_langd_fisken}()},
\code{\link{kul_langd_lan}()},
\code{\link{kul_langd_lokaler}()}
}
\concept{KulLangd API functions}
