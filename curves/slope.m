function [x_positions, y_positions, velocities, accelerations, time, finalPosition] = slope(initial_velocity, slope_theta, initial_position, initial_time, final_position)

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

    % Move right to left
    if(initial_position(1) > final_position(1))
        while  oldPosition(1) >  final_position(1)
            [deltaPosition, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME,1);
            oldPosition = deltaPosition + oldPosition;
            x(n) = oldPosition(1);
            y(n) = oldPosition(2);
            all_velocities(n) = norm(finalVelocity);
            all_accelerations(n) = norm(finalVelocity - getOldVelocity(0))/DELTA_TIME;
            elasped_time = DELTA_TIME + elasped_time;
            n = n + 1;
            setOldVelocity(finalVelocity(1), finalVelocity(2));
        end
    else % moving left to right
        while  oldPosition(1) < final_position(1)
            [deltaPosition, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME,1);
            oldPosition = deltaPosition + oldPosition;
            x(n) = oldPosition(1);
            y(n) = oldPosition(2);
            all_velocities(n) = norm(finalVelocity);
            all_accelerations(n) = norm(finalVelocity - getOldVelocity(0))/DELTA_TIME;
            elasped_time = DELTA_TIME + elasped_time;
            n = n + 1;
            setOldVelocity(finalVelocity(1), finalVelocity(2));
        end
    end
    
    %elasped_time = DELTA_TIME*n;
    %% Finalize values that we will return
    time = initial_time + elasped_time;
    
    numOfPoints = floor(elasped_time/PLOT_TIME);
    increment = floor(length(all_velocities) / numOfPoints);
    
    velocities = 1:numOfPoints;
    accelerations = 1:numOfPoints;
    x_positions = 1:numOfPoints;
    y_positions = 1:numOfPoints;
    
    % always include initial value. 
    % Would we wanna always include final value?
    velocities(1) = all_velocities(1);
    accelerations(1) = all_accelerations(1);
    x_positions(1) = x(1);
    y_positions(1) = y(1);
    
    for idx = 1:(numOfPoints)
        velocities(idx) = all_velocities(idx*increment);
        accelerations(idx) = all_accelerations(idx*increment);
        x_positions(idx) = x(idx*increment);
        y_positions(idx) = y(idx*increment);
    end
    
    finalPosition = [x(length(x)), y(length(y))];

end



