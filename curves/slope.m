
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
    setTheta(slope_theta);
    elasped_time = 0;
    n = 1;

    while oldPosition(2) > final_position
        [position, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME,1);
        oldPosition = position + oldPosition;
        x(n) = oldPosition(1);
        y(n) = oldPosition(2);
        all_velocities(n) = norm(finalVelocity);
        all_accelerations(n) = norm(finalVelocity)/DELTA_TIME;
        elasped_time = DELTA_TIME + elasped_time;
        n = n + 1;
        setOldVelocity(finalVelocity(1), finalVelocity(2));
    end

    %elasped_time = DELTA_TIME*n;
    final_time = elasped_time + initial_time;


    %% Finalize values that we will return

    
    numOfPoints = floor(elasped_time/PLOT_TIME) %rounding to lower number
    
    velocities = 1:numOfPoints;
    accelerations = 1:numOfPoints;
    positions = zeros(numOfPoints, 2);
    
    for idx = 1:floor(n/numOfPoints):n-1
        velocities(idx) = all_velocities(idx);
        accelerations(idx) = all_accelerations(idx);
        positions(idx,1) = x(idx);
        positions(idx,2) = y(idx);
    end

end



