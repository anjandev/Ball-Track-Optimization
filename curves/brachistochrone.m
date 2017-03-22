function [positions, velocities, accelerations, final_time] = brachistochrone(initial_velocity, curve_size, initial_position, initial_time)
    
    global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME

    % BRACHISTOCHRONE 
    % Funcntion takes in initial parameters, generates a curve and outputs
    % final calculations (initial parameters + change after going through curve) 
    % and vectors containing velocities, accelerations, positions at each time
    % interval
    setOldVelocity(initial_velocity(1), initial_velocity(2));
    
    
    %% Generate curve
    DIVISIONS = 1000;
    t = linspace(0, pi, DIVISIONS); %%define t for parametric equations (1000 divisions)

    x = initial_position(1) + (curve_size)*(t-sin(t)); %% x equation
    y = initial_position(2) + (curve_size)*(-1+cos(t)); %% y equation
    

    %% Find Slopes
    % I can do this two ways, I can either use equation or just do
    % delta y/delta x
    slopes_theta = 1:(length(y)-1);

    for idx = 1:length(y)-1
        slopes_theta(idx) = atan2(y(idx+1)-y(idx), x(idx+1)-x(idx));
    end

    %% Setting up velocity and acceleration temporary storage vectors
    elasped_time = 0;
    all_velocities = 1:length(slopes_theta);
    all_accelerations = 1:length(slopes_theta);
    
    oldPosition = initial_position;
    
    %% Calculate velocities, accelerations and times to reach each position
    for idx = 1:length(slopes_theta)
    
        setTheta(slopes_theta(idx));
        [delta_position, finalVelocity] = slopeNoSlipping((y(idx+1) - y(idx)),2);

        if idx == 1
            all_velocities(idx) = norm(finalVelocity);
        else
            all_velocities(idx) = norm(finalVelocity);
            delta_time = norm([x(idx) - x(idx -1), y(idx) - y(idx -1)]) / norm(finalVelocity);
            oldVelocity = getOldVelocity(0);
            all_accelerations(idx) = norm((finalVelocity - oldVelocity) / (delta_time));
            elasped_time = delta_time + elasped_time;

        end

        setOldVelocity(finalVelocity(1),finalVelocity(2));
        oldPosition = delta_position + oldPosition;
    
    end
    
    %% Finalize values that we will return
    final_time = initial_time + elasped_time;
    
    numOfPoints = floor(elasped_time/PLOT_TIME);
    
    velocities = 1:numOfPoints;
    accelerations = 1:numOfPoints;
    positions = zeros(numOfPoints, 2);
    
    for idx = 1:floor(DIVISIONS/numOfPoints):DIVISIONS-1
        velocities(idx) = all_velocities(idx);
        accelerations(idx) = all_accelerations(idx);
        positions(idx, 1) = x(idx);
        positions(idx, 2) = y(idx);
    end
    
end