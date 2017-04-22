
#--- Checkin installed packages and install missing ones
list.of.packages <- c("fPortfolio")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if (length(new.packages)) {
  install.packages(new.packages)
}

library(fPortfolio)

#--- Subsetting SWX
SWX[start(SWX), ]

SWX[start(sample(SWX)), ]

SWX[start(sample(SWX, 10)), ]

#--- Subsetting by column name
tail(SWX[,"SPI"])

head(letters, n=10L)
tail(letters, n=-10L)

#--- SUbsetting by date stamps
SWX["2007-04-24"]                                                   # Retorna N/A
SWX["2007-04-24", ]

#--- Subsetting all records from the 1Q and 2Q
round(window(SWX, start = "2006-01-15", end = "2006-01-21"), 1)     # round to one decimal digit
                                                                    # Other rounding functions: ceiling(), floor(), truncate() and signif()

#--- Aggregating time series. Fine-grained resolution to coarse-grained-resolution (e.g. from daily to monthly)

charvec <- timeCalendar()
data <- matrix(round(runif(24,0,10)), 12)                           # runif - Uniform Distribution, sample size = 24, min = 0, max = 0
                                                                    # matrix - creates a matrix, number of rows = 12
tS <- timeSeries(data, charvec)                                     # timeSeries - creates a 'timeSeries' object

by <- unique(timeLastDayInQuarter(charvec))                         # Computes the last day in a quarter, removing eventual duplicates
                                                                    # Other function with similar goal:
                                                                    #     - timeLastDayInMonth
                                                                    #     - timeFirstDayInMonth
                                                                    #     - timeLastDayInQuarter
                                                                    #     - timeFirstDayInQuarter
                                                                    #     - timeNdayOnOrAfter: date month that is a n-day ON OR AFTER
                                                                    #     - timeNdayOnOrBefore: date in month that is a n-day ON OR BEFORE
                                                                    #     - timeNthNdayInMonth: nth occurrence of a n-day in year/month

aggregate(tS, by, FUN = sum, units = c("TSQ.1", "TSQ.2"))           # Aggregating monthly sums by quarter
