function [M] = model(x, W)

y = actFun(W{1}*x);
for i = 2:length(W)
    y=actFun(W{i}*y);
end
M = y;
end