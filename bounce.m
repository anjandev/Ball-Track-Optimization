function [omega] = bounce(energy_remain, initial_velocity)
global MASS

if getTheta() < pi/2 && getTheta() > 0
    x_velocity = -energy_remain*abs(initial_velocity(1));
    y_velocity = energy_remain*abs(initial_velocity(2));
    
    setOldVelocity(x_velocity,y_velocity)
    setTheta(abs(getTheta())+pi/2)
end

omega = 0;

end

