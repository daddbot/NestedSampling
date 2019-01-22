function [logL] = logLhood(x,y)
%LOGLHOOD lates
%   x: Easterly position
%   y: Northerly position
%    This function accumulates log likelihood for the  given data

global D;
N = size(D,2);
logL = 0;

for index = 1:N
    logL = logL + (log((y/pi) / ( (D(index) - x)...
        * (D(index)-x) + y*y) ));
end
end