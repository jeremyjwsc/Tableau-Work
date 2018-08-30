

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
