

[Obj, Samples, Try, n, MAX] = apply;
logZ = - realmax;
H = 0.0;

for index = 1:n
    Obj(index) = Prior(Obj(index));
end

logwidth = log(1.0 - exp(-1.0/n));

%NESTED SAMPLING LOOP
for nest = 1:MAX
    %Worst object in collection, with Weight = width * Likelihood
    worst = 1;
    for i = 2:n
        if (Obj(i).logL < Obj(worst).logL)
           worst = i; 
        end
    end
    Obj(worst).logWt = logwidth + Obj(worst).logL;
    
    %Update Evidence Z and Info H
    if(logZ > Obj(worst).logWt)  %Implement PLUS here
        logZnew = logZ + log(1 + exp(Obj(worst).logWt - logZ));
    else
        logZnew = Obj(worst).logWt ...
            + log(1 + exp(logZ - Obj(worst).logWt));
    end
    H = exp(Obj(worst).logWt - logZnew) * Obj(worst).logL ...
        + exp(logZ - logZnew) * (H + logZ) - logZnew;
    logZ = logZnew;
    
    %Posterior Samples
    Samples(nest) = Obj(worst);
    
    %Kill worst object in favor of copy of different survivor
    copy = ceil(n * rand()); % choose another object
    while((copy == worst) && n>1)
        copy = ceil(n * rand()); % choose another object
    end
    logLstar = Obj(worst).logL; % new likelihood constant
    Obj(worst) = Obj(copy); % overwrite worst object
    
    
    
    % Evolve copied object within constraint
    
    % Shrink interval
    logwidth = logwidth - 1.0 / n;
end
fprintf("# iterates = %d\n", nest);
fprintf("Evidence: ln(Z) = %d +- %d\n", logZ, sqrt(H/n));
fprintf("Information: H = %d nats = %d bits\n", H, H/log(2.0));
[mX,sX,mY,sY] = Results(Samples,nest,logZ);
fprintf("mean(x) = %d, stdDev(x) = %d\n", mX,sX);
fprintf("mean(y) = %d, stdDev(y) = %d\n", mY,sY);


