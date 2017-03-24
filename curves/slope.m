
function [positions, velocities, accelerations, final_time] = slope(initial_velocity, slope_theta, initial_position, initial_time, final_position)

global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME

% SLOPE
% Function takes in initial parameters, generates a curve and outputs
% final calculations (initial parameters + change after going through curve)
% and vectors containing velocities, accelerations, positions at each time
% interval

% TODO: OUTPUT THE positions, velocities, accelerations


setOldVelocity(initial_velocity(1), initial_velocity(2));
oldPosition = initial_position;
setTheta(slope_theta)

timer = initial_time;

n = 1;
while oldPosition(2) > final_position
    [position, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME,1);
    oldPosition = position + oldPosition;
    timer = DELTA_TIME + timer;
    positions(n,1) = oldPosition(1);
    positions(n,2) = oldPosition(2);
    velocities(n) = norm(finalVelocity);
    accelerations(n) = norm(finalVelocity)/DELTA_TIME;
    n = n + 1;
    setOldVelocity(finalVelocity(1), finalVelocity(2));
    
end

final_time = timer;

end



