
##10 Sales_Forecast_3 -------------------

SCRIPT_REAL("library(forecast);

time <-ts(.arg1, start=c(2013,1), frequency=12);

fcast <- forecast(time, h=.arg2[1]);

n<-length(.arg1); 

append(.arg1[(.arg2[1]+1):n],fcast$mean, after = n-.arg2[1])",

SUM( [Sales Eur]),[Sales Months to Forecast])