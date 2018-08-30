
##5 Sales_Complex_TS_MA -------------------------

SCRIPT_REAL("
    library(forecast)

    ## Creating vectors

    hold.orig <- .arg4
    len.orig <- length( hold.orig )
    len.new <- len.orig - hold.orig[1]

    year.orig <- .arg2
    month.orig <- .arg1
    sales.orig <- .arg3

    ## Sorting the Data

    date.orig <- year.orig + month.orig / 12
    dat.orig <- cbind(year.orig, month.orig, sales.orig)[sort(date.orig, index.return = TRUE)$ix,]
    dat.new <- dat.orig[1:len.new,]

    ## Fitting the Time Series

    timeser <- ts(dat.new[,3], start = c(dat.new[1,1], dat.new[1,2]), end = c(dat.new[len.new,1], dat.new[len.new,2]), frequency = 12)
    rep(acf(timeser, plot=FALSE)$acf,5)[1:len.orig]
"

, ATTR( MONTH( [Date] ) ), ATTR( YEAR( [Date] ) ), SUM( [Sales Eur] ),
 [Seed] )