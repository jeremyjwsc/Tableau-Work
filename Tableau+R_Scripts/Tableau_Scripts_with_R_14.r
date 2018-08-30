
##13 Sales_Predicted -----------------

SCRIPT_REAL(" 

fore <- .arg1;

cons <- .arg2;

q <- .arg3;

fit <- lm(fore ~ cons + q);

fit$fitted;",

sum([Sales Eur]), sum([Cost Eur]),  sum([Q]))