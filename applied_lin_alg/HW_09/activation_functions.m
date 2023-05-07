% Matlab:
sigmoid = @(x) 1.0./(1.0+exp(-x));
softmax = @(x) exp(x)/sum(exp(x(:)));
tansig = @(x) 2./(1+exp(-2.0*x))-1;
% and for rectified linear, place a
% regular function in a file rectlin.m:
function out=rectlin(x)
out=x;
out(out<0)=0;
% and then used as,
z=[1 2 3];
sigmoid(z)
% or
softmax(z)
end