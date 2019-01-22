function [meanX,stdDevX,meanY,stdDevY] = Results(Samples, nest, logZ)
%RESULTS Summary of this function goes here
%   Detailed explanation goes here
x  = 0.0;   %1st moment of x
xx = 0.0;   %2nd moment of x
y  = 0.0;   %1st moment of y
yy = 0.0;   %2nd moment of y
for i = 1:nest
    w  = exp(Samples(i).logWt - logZ);
    x  = x  + (w * (Samples(i).x)  );
    xx = xx + (w * (Samples(i).x)^2);
    y  = y  + (w * (Samples(i).y)  );
    yy = yy + (w * (Samples(i).y)^2);
end
meanX = x; meanY = y;
stdDevX = sqrt(xx - (x^2) ); 
stdDevY = sqrt(yy - (y^2) );
end

