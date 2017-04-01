function [x_positions, y_positions, velocities, accelerations, time, omegas, alphas] = free(velocity, time, position, xStopperLoc, yStopperLoc, bottom)
    n = 1;
    global GRAVITY DELTA_TIME KINETIC_FRICTION MASS BALLRADIUS INERTIA MOVING_RIGHT MOVING_LEFT PLOT_TIME
    
    elasped_time = 0;
    
    while position(1) < xStopperLoc && position(2) < yStopperLoc
        position = velocity * DELTA_TIME + position; + (1/2)*GRAVITY*[0,1]*DELTA_TIME^2;
        x(n) = position(1);
        y(n) = position(2);
        all_velocities(n) = norm(velocity);
        all_accelerations(n) =  GRAVITY;
        
        velocity = velocity + GRAVITY * DELTA_TIME * [0, 1];
        
        n = n +1;
        elasped_time = elasped_time + DELTA_TIME;
        
    end
    
    % WANT IMPULSE HERE. BUT IM ASSUMING ENERGY IS CONSERVED
    
    velocity = norm(velocity) * [0, -1];
    
    while position(2) > bottom
        position = velocity * DELTA_TIME + position + (1/2)*GRAVITY*[0,1]*DELTA_TIME^2;
        x(n) = position(1);
        y(n) = position(2);
        all_velocities(n) = norm(velocity);
        all_accelerations(n) =  -GRAVITY;
        
        velocity = velocity + GRAVITY * DELTA_TIME * [0, 1];
        
        n = n +1;
        elasped_time = elasped_time + DELTA_TIME;
        
    end
%     
%     
    
    time = time + elasped_time;

    numOfPoints = floor(elasped_time/PLOT_TIME);
    increment = floor(length(all_velocities) / numOfPoints);

    velocities = 1:numOfPoints;
    accelerations = 1:numOfPoints;
    x_positions = 1:numOfPoints;
    y_positions = 1:numOfPoints;
    omegas = 1:numOfPoints;
    alphas = 1:numOfPoints;
    

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
        omegas(idx) = 0;
        alphas(idx) = 0;
  
    end
    
    velocities(length(velocities)) = all_velocities(length(all_velocities));
    accelerations(length(velocities)) = all_accelerations(length(all_accelerations));
    x_positions(length(velocities) + 1) = x(length(x));
    y_positions(length(velocities) + 1) = y(length(y));
    
end

