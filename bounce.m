function [omega,impulse_acceleration,time] = bounce(energy_remain, initial_velocity,time)
global MASS
impulse_time = 0.001;

if getTheta() < pi/2 && getTheta() > 0
    x_velocity = -(energy_remain*initial_velocity(1)^2)^0.5;
    y_velocity = (energy_remain*(initial_velocity(2))^2)^0.5;
    
    setOldVelocity(x_velocity,y_velocity);
    setTheta(abs(getTheta())+pi/2);
    
    impulse_acceleration = (getOldVelocity(3)+ norm(initial_velocity))/impulse_time;
    
    time = impulse_time + time;
end

omega = 0;


end

