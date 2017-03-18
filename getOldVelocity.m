function y = getOldVelocity(n)
global GsetOldVelocity
if n == 1
    y = GsetOldVelocity(1); %%1 = x value
elseif n == 2
    y = GsetOldVelocity(2); %%2 = y value
elseif n == 3
    y = norm(GsetOldVelocity);
else
    y = GsetOldVelocity;
end
        
        