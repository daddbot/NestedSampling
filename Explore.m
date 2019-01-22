function Obj = Explore(Obj,Try, logLstar)
%EXPLORE Summary of this function goes here
%   Detailed explanation goes here
step = 0.1;
m = 20;
accept = 0;
reject = 0;

for loopIndex = m:-1:1
    Try.u = Obj.u + step * (2.0 * rand() - 1.0);  
    Try.v = Obj.u + step * (2.0 * rand() - 1.0);  
    Try.u = Try.u - floor(Try.u);
    Try.v = Try.v - floor(Try.v);
    Try.x = 4.0 * Try.u - 2.0;
    Try.y = 2.0 * Try.v;
    Try.logL = logLhood(Try.x,Try.y);
    %Accept if and only if within hard likelihood constraint
    if (Try.logL > logLstar) 
        Obj = Try;
        accept = accept + 1;
    else
        reject = reject + 1;
    end
    if (accept > reject) 
        step = step * exp(1.0/accept);
    end
    if (accept < reject)
        step = step / exp(1.0/reject);
    end
end %end for
end




