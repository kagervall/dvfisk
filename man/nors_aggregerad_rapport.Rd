% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/NorsAggregerad.R
\name{nors_aggregerad_rapport}
\alias{nors_aggregerad_rapport}
\title{Get aggregated data from the Nors API}
\usage{
nors_aggregerad_rapport(Lan = NULL, HaroNr = NULL, Sjo = NULL)
}
\arguments{
\item{Lan}{character string with the name of a county (län) in Sweden}

\item{HaroNr}{integer with the main drainage area (huvudavrinningsområde) number}

\item{Sjo}{character string with the name a lake (sjö) in Sweden}
}
\value{
A data frame with the electrofishing data. There are 44 columns in the data frame
consult Nors-documentation.
}
\description{
This function returns electrofishing data from the Nors API. You can filter the data by
county (Lan), main drainage area (HaroNr) or lake (Sjo). The function
does not check if the parameters are valid and it is possible to give combinations
that does not make sense, e.g. a \code{haroNr} and \code{Lan} that does not intersect.
It is also possible send requests that return a lot of data, so be careful.
}
\examples{
# This example will access the Internet to get the data and will not work offline
# Get all data from the main drainage area 24000 (Rickleån).
data <- nors_aggregerad_rapport(HaroNr = 24000)
head(data)
dim(data)
}
\seealso{
Description of \url{https://www.slu.se/en/departments/aquatic-resources1/databases/national-register-of-survey-test-fishing-nors/},
description of API \url{https://dvfisk.slu.se/swagger/index.html}

Other NorsAggregerad API functions: 
\code{\link{nors_aggregerad_huvudavrinningsomraden}()},
\code{\link{nors_aggregerad_lan}()}
}
\concept{NorsAggregerad API functions}
