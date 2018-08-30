
##9 Sales_Forecast_2 ----------------------

SCRIPT_REAL(" 

library(forecast);

time <-ts(.arg1, start=c(2013,1), frequency=12);

arimaML<- auto.arima(time);

fcast <-forecast(arimaML, h=.arg2[1]);

n<- length(.arg1);

append(.arg1[(.arg2[1]+1):n], fcast$mean, after=n-.arg2[1])",

sum([Sales Eur]),[Sales Eur Frequency] )