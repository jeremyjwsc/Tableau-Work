
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
