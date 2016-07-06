clear;
alpha = rand(1,10000);
beta = rand(1,10000)
histogram([alpha,beta]);
val1 = sqrt(-2 * log(alpha)) .* sin(2 * pi * beta);
val2 = sqrt(-2 * log(alpha)) .* cos(2 * pi * beta);
hist([val1,val2],10000);
