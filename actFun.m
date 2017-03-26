% Sigmoid activation function. recursive function which will also
% return the classification of new instance, x after trained.
function x = f(x)
    x=1./(1+exp(-x));
