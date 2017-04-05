function [x_positions, y_positions, velocities, accelerations, final_time, finalPosition, omegas, alphas, omegaFinal] = brachistochrone(initial_velocity, curve_size, initial_position, initial_time, initial_omega)

    global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME KINETIC_FRICTION STATIC_FRICTION

    % BRACHISTOCHRONE
    % Funcntion takes in initial parameters, generates a curve and outputs
    % final calculations (initial parameters + change after going through curve)
    % and vectors containing velocities, accelerations, positions at each time
    % interval
    setOldVelocity(initial_velocity(1), initial_velocity(2));

    %% Generate curve
    DIVISIONS = 1000;
    t = linspace(0, 1*pi, DIVISIONS); %%define t for parametric equations (1000 divisions)
    

    %     %% Setting up velocity and acceleration temporary storage vectors
    %     elasped_time = 0;
    %     all_velocities = 1:length(slopes_theta);
    %     all_accelerations = 1:length(slopes_theta);
    %         
    %     %% Calculate velocities, accelerations and times to reach each position
    %     for idx = 1:length(slopes_theta)
    %     
    %         setTheta(slopes_theta(idx));
    %         [~, finalVelocity] = slopeNoSlipping((y(idx+1) - y(idx)),1);


    x = initial_position(1) + (curve_size)*0.1940417*(t-sin(t)); %% x equation
    y = initial_position(2) + (curve_size)*0.3048*(-1+cos(t)); %% y equation
    
    % 10% x = 0.1619, y = 0.3124
    %-10% x = 0.2420568741


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

    %% Calculate velocities, accelerations and times to reach each position
    x_positions(1) = x(1);
    y_positions(1) = y(1);
    timeSinceLastSnap = 0;
    positionSnaps = 2;
    
    for idx = 1:length(slopes_theta)
        
        if(timeSinceLastSnap > PLOT_TIME)
            timeSinceLastSnap = 0;
            x_positions(positionSnaps) = x(idx);
            y_positions(positionSnaps) = y(idx);
            positionSnaps = positionSnaps + 1;
        end

        setTheta(slopes_theta(idx));
        
        if  STATIC_FRICTION < abs((2/7)*tan(getTheta()))
            [~, finalVelocity, acceleration] = slopeSlipping([(x(idx+1) - x(idx)), (y(idx+1) - y(idx))] ,1);

        else
            [~, finalVelocity, acceleration] = slopeNoSlipping((y(idx+1) - y(idx)),1);

        end

        delta_time = 0;
        
        if idx == 1
            all_velocities(idx) = norm(finalVelocity);
            all_accelerations(idx) = acceleration;
            setOldVelocity(finalVelocity(1),finalVelocity(2));
        else
            all_velocities(idx) = norm(finalVelocity);
            delta_time = norm([x(idx) - x(idx -1), y(idx) - y(idx -1)]) / norm(finalVelocity);
            %all_accelerations(idx) = norm((finalVelocity - [getOldVelocity(1), getOldVelocity(2)]) / delta_time);
            all_accelerations(idx) = acceleration;
            elasped_time = delta_time + elasped_time;
            setOldVelocity(finalVelocity(1) + acceleration*cos(getTheta())*delta_time,finalVelocity(2) + acceleration*sin(getTheta())*delta_time);
        end
        
        if  STATIC_FRICTION < abs((2/7)*tan(getTheta()))
            all_alpha(idx) = (KINETIC_FRICTION*cos(getTheta)*MASS*GRAVITY*BALLRADIUS)/INERTIA;
            if idx ==1
                all_omega(idx) = initial_omega;
            else
                all_omega(idx) = all_omega(idx-1) + all_alpha(idx)*delta_time;
            end
            
        else
            all_alpha(idx) = acceleration / BALLRADIUS;
            all_omega(idx) = norm(finalVelocity) / BALLRADIUS;
        end
        
        timeSinceLastSnap = timeSinceLastSnap + delta_time;
    end

    %% Finalize values that we will return
    final_time = initial_time + elasped_time;

    numOfPoints = floor(elasped_time/PLOT_TIME);
    increment = floor(DIVISIONS / numOfPoints);
    
    velocities = 1:numOfPoints;
    accelerations = 1:numOfPoints;
    omegas = 1:numOfPoints;
    alphas = 1:numOfPoints;
    
    % always include initial value.
    % Would we wanna always include final value?
    velocities(1) = all_velocities(1);
    accelerations(1) = all_accelerations(1);
    omegas(1) = all_omega(1);
    alphas(1) = all_alpha(1);
    
    for idx = 1:(numOfPoints)
        velocities(idx) = all_velocities(idx*increment);
        accelerations(idx) = all_accelerations(idx*increment);
        omegas(idx) = all_omega(idx*increment);
        alphas(idx) = all_alpha(idx*increment);
        
    end
    
    velocities(length(velocities)) = all_velocities(length(all_velocities));
    accelerations(length(velocities)) = all_accelerations(length(all_accelerations));
    omegaFinal = omegas(length(omegas));
    omegas(length(velocities)) = all_omega(length(all_velocities));
    alphas(length(velocities)) = all_alpha(length(all_velocities));
    
    finalPosition = [x(length(x)), y(length(y))];

end
