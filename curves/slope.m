function [positions, velocities, accelerations, final_time] = slope(initial_velocity, slope_theta, initial_position, initial_time, final_position)
    
    global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME

    % SLOPE 
    % Function takes in initial parameters, generates a curve and outputs
    % final calculations (initial parameters + change after going through curve) 
    % and vectors containing velocities, accelerations, positions at each time
    % interval
    
    % TODO: OUTPUT THE positions, velocities, accelerations
    
    setTheta(slope_theta);
    setOldVelocity(initial_velocity(1), initial_velocity(2));
    
    oldPosition = initial_position;
    
    timer = initial_time;
        
    while oldPosition(2) > final_position
        [position, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME,1);
        oldPosition = position + oldPosition;
        timer = DELTA_TIME + timer;
    end
    
    final_time = timer;
    

end

