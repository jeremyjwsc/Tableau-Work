
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