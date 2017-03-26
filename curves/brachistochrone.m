function [x_positions, y_positions, velocities, accelerations, final_time, finalPosition] = brachistochrone(initial_velocity, curve_size, initial_position, initial_time,initial_omega)

    global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME KINETIC_FRICTION STATIC_FRICTION

    % BRACHISTOCHRONE
    % Funcntion takes in initial parameters, generates a curve and outputs
    % final calculations (initial parameters + change after going through curve)
    % and vectors containing velocities, accelerations, positions at each time
    % interval
    setOldVelocity(initial_velocity(1), initial_velocity(2));

    %% Generate curve
    DIVISIONS = 100000;
    t = linspace(0, pi, DIVISIONS); %%define t for parametric equations (1000 divisions)
    

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
            idx
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
            all_accelerations(idx) = norm((finalVelocity - [getOldVelocity(1), getOldVelocity(2)]) / delta_time);
            elasped_time = delta_time + elasped_time;
            setOldVelocity(finalVelocity(1) + acceleration*cos(getTheta())*delta_time,finalVelocity(2) + acceleration*sin(getTheta())*delta_time);
        end
        timeSinceLastSnap = timeSinceLastSnap + delta_time;
    end

    %% Finalize values that we will return
    final_time = initial_time + elasped_time;

    numOfPoints = floor(elasped_time/PLOT_TIME);
    increment = floor(DIVISIONS / numOfPoints);

    velocities = 1:numOfPoints;
    accelerations = 1:numOfPoints;


    % always include initial value.
    % Would we wanna always include final value?
    velocities(1) = all_velocities(1);
    accelerations(1) = all_accelerations(1);


    for idx = 1:(numOfPoints-1)

%         % finding the alpha and omega depending on slip condition
%         if getTheta() > -atan(STATIC_FRICTION)
%             slip
%             alpha = (KINETIC_FRICTION*cos(slopes_theta(idx*increment))*MASS*GRAVITY*BALLRADIUS)/INERTIA;
%             if idx == 1
%                 omega(idx) = alpha*elasped_time + initial_omega;
%             else
%                 omega(idx) = alpha*elasped_time + omega(idx-1);
%             end
%         else % NO SLIPPING
%             alpha(idx) = accelerations(idx)/BALLRADIUS;
%             omega(idx) = velocities(idx)/BALLRADIUS;
%         end


        velocities(idx) = all_velocities(idx*increment);
        accelerations(idx) = all_accelerations(idx*increment);


        
    end
    
    velocities(length(velocities)) = all_velocities(length(all_velocities));
    accelerations(length(velocities)) = all_accelerations(length(all_accelerations));
    x_positions(length(velocities) + 1) = x(length(x));
    y_positions(length(velocities) + 1) = y(length(y));
    
    finalPosition = [x(length(x)), y(length(y))];

end