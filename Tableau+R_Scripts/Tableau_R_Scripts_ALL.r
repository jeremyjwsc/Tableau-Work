

#install.packages("Rserve",dependencies=TRUE)

library(Rserve)

Rserve()


##1 Sales Forecast --------------------

SCRIPT_REAL("library(forecast);

time <- ts(.arg1,start=c(2016,1), frequency=12);

fcast <- forecast(time, h=.arg2[1]);

n<-length(.arg1); 

append(.arg1[(.arg2[1]+1):n],fcast$mean, 

after = n-.arg2[1])",

SUM([Sales Eur]),[Sales Eur Frequency])


##2 Sales_ARIMA -----------------------

SCRIPT_REAL("

library(forecast); 

x<-.arg1;

arima.1<-arima(ts(x,start=c(2006,01),frequency=12),order=c(2,1,1),

seasonal=list(order=c(0,2,0)),method='ML');

prog<-forecast(arima.1,h=24);

u<-as.numeric(prog$mean);

n<-length(ts(x,start=c(2008,01),frequency=12));

append(x[25:n],u,after=n)",

SUM([Sales Eur]))

##3 Sales_ARIMA_2 ----------------------

SCRIPT_REAL("

  library(forecast);

  l = length(.arg1);
  
  u = .arg1[1:(l-.arg2[1])];
  
  n = length(u);
 
  u[n] = .arg1[l];

# Code start 
 
  data <- ts(u,frequency=.arg3[1]);
 
  data.arima = auto.arima(data,trace=F,stepwise=T,seasonal=T)
 
  fcast <- forecast(data.arima, h=.arg2[1]);

# code end 
 
  append(u,fcast$mean, after = n)",
  
SUM([Sales Eur]),[Sales Eur Forecast Intervals],[Sales Eur Frequency])


##4 Sales_Complex_TS_AR --------------------

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
    dat.orig <- cbind(year.orig, month.orig, sales.orig)[sort(date.orig, 
                        index.return = TRUE)$ix,]
    dat.new <- dat.orig[1:len.new,]

    ## Fitting the Time Series

    timeser <- ts(dat.new[,3], start = c(dat.new[1,1], dat.new[1,2]), 
            end = c(dat.new[len.new,1], dat.new[len.new,2]), frequency = 12)
    rep(pacf(timeser, plot=FALSE)$acf,5)[1:len.orig]"

, ATTR( MONTH( [Date] ) ), ATTR( YEAR( [Date] ) ), SUM( [Sales Eur] ),
 [Seed] )

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
 
 ##6 Sales_Cost (Normalized) ----------------------------
 
 SCRIPT_REAL("
## Sets the seed
set.seed(.arg4[1]);

Sales <- (.arg1 - mean(.arg1))/sd(.arg1);
Cost <- (.arg2 - mean(.arg2))/sd(.arg2);


dat <- cbind(Sales, Cost);

num <- .arg3

## create cluster

result<-kmeans(dat, num); result$cluster;",

sum([Sales Eur]), sum([Cost Eur]),[Number of Clusters],[Seed])

##7 Sales_Cost_Seg ------------------------------------

SCRIPT_INT(

'result <- kmeans(data.frame(.arg1,.arg2), 4);
 
 result$cluster;',

sum([Sales Eur]),sum([Cost Eur]))

##8 Sales_Forecast _CI Original ----------------------------

SCRIPT_REAL("

library(forecast);

Sdata <- .arg1;

periods <- .arg2[1];

freq <- .arg3[1];
 
nulls <- length(Sdata[is.na(Sdata)]);

Sdata <- Sdata[!is.na(Sdata)];

time <- ts(Sdata,frequency=freq);

fcast <- stlf(time, h=periods);

n <- length(Sdata);

result <- append(Sdata[(periods+1):n],fcast$mean);

result <- append(result,rep(NaN,nulls));

result;",

sum([Sales Eur]),[Sales Months to Forecast],[Sales Eur Frequency])

##9 Sales_Forecast_2 ----------------------

SCRIPT_REAL(" 

library(forecast);

time <-ts(.arg1, start=c(2013,1), frequency=12);

arimaML<- auto.arima(time);

fcast <-forecast(arimaML, h=.arg2[1]);

n<- length(.arg1);

append(.arg1[(.arg2[1]+1):n], fcast$mean, after=n-.arg2[1])",

sum([Sales Eur]),[Sales Eur Frequency] )

##10 Sales_Forecast_3 -------------------

SCRIPT_REAL("library(forecast);

time <-ts(.arg1, start=c(2013,1), frequency=12);

fcast <- forecast(time, h=.arg2[1]);

n<-length(.arg1); 

append(.arg1[(.arg2[1]+1):n],fcast$mean, after = n-.arg2[1])",

SUM( [Sales Eur]),[Sales Months to Forecast])

#11 Sales_Forecast_CI Lower 95% ---------------

SCRIPT_REAL("

library(forecast);

Sdata <- .arg1;

periods <- .arg2[1];

freq <- .arg3[1];
 
nulls <- length(Sdata[is.na(Sdata)]);

Sdata <- Sdata[!is.na(Sdata)];

time <- ts(Sdata,frequency=freq);

fcast <- stlf(time, h=periods);

n <- length(Sdata);

result <- append(Sdata[(periods+1):n],fcast$lower[,2]);

result <- append(result,rep(NaN,nulls));

result;",

sum([Sales Eur]),[Sales Months to Forecast],[Sales Eur Frequency])

##12 Sales_Forecast_CI Lower 95% ---------------------

SCRIPT_REAL("

library(forecast);

Sdata <- .arg1;

periods <- .arg2[1];

freq <- .arg3[1];
 
nulls <- length(Sdata[is.na(Sdata)]);

Sdata <- Sdata[!is.na(Sdata)];

time <- ts(Sdata,frequency=freq);

fcast <- stlf(time, h=periods);

n <- length(Sdata);

result <- append(Sdata[(periods+1):n],fcast$upper[,2]);

result <- append(result,rep(NaN,nulls));

result;",

sum([Sales Eur]),[Sales Months to Forecast],[Sales Eur Frequency])

##13 Sales_Predicted -----------------

SCRIPT_REAL(" 

fore <- .arg1;

cons <- .arg2;

q <- .arg3;

fit <- lm(fore ~ cons + q);

fit$fitted;",

sum([Sales Eur]), sum([Cost Eur]),  sum([Q]))

##14 Sales_TS_Residuals ------------------

SCRIPT_REAL("

    library(forecast);
    
    data <- ts(.arg1,frequency=.arg2[1]);

# Code start 

   data.stl = stl(x=data,s.window='periodic');   

  # time.series[,1] for Seasonal
  # data.Seasonal = data.stl$time.series[,1]

  # time.series[,2] for Trend
  # data.trend = data.stl$time.series[,2]


  # time.series[,3] for Residuals
   data.residuals = data.stl$time.series[,3]


# code end

",SUM([Sales Eur]),[Sales Eur Frequency])

#15 Sales_TS_Trend_Line -------------------

SCRIPT_REAL("

    library(forecast);
    
    data <- ts(.arg1,frequency=.arg2[1]);

# Code start 

   data.stl = stl(x=data,s.window='periodic');   

  # time.series[,1] for Seasonal
  # data.Seasonal = data.stl$time.series[,1]


  # time.series[,2] for Trend
    data.trend = data.stl$time.series[,2]


  # time.series[,3] for Residuals
  # data.residuals = data.stl$time.series[,3]



# code end

",SUM([Sales Eur]),[Sales Eur Frequency])















