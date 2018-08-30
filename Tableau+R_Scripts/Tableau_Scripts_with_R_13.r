
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