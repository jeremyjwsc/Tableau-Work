
##7 Sales_Cost_Cluster ------------------------------------

SCRIPT_INT(

'result <- kmeans(data.frame(.arg1,.arg2), 4);
 
 result$cluster;',

sum([Sales Eur]),sum([Cost Eur]))