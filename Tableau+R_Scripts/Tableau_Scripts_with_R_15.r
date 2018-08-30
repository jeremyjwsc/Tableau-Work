
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