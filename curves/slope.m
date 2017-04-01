function [x_positions, y_positions, velocities, accelerations, time, finalPosition, omegas, alphas, omegaFinal] = slope(initial_velocity, initial_position, initial_time, final_position, initial_omega)

    global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME KINETIC_FRICTION STATIC_FRICTION
    

    % SLOPE
    % Function takes in initial parameters, generates a curve and outputs
    % final calculations (initial parameters + change after going through curve)
    % and vectors containing velocities, accelerations, positions at each time
    % interval

    % TODO: OUTPUT THE positions, velocities, accelerations


    
    
    oldPosition = initial_position;
    setTheta(atan((initial_position(2) - final_position(2))/(initial_position(1) - final_position(1))));
    
    
    setOldVelocity(norm(initial_velocity)*cos(getTheta()), norm(initial_velocity)*sin(getTheta()));

    
    elasped_time = 0;
    n = 1;


    % Move right to left
    if(initial_position(1) > final_position(1))

        while  oldPosition(1) >  final_position(1)
            if STATIC_FRICTION < abs((2/7)*tan(getTheta()))
                [deltaPosition, finalVelocity, acceleration] = slopeSlipping((getOldVelocity(2))*DELTA_TIME, 0);
                all_accelerations(n) = acceleration;
                all_alpha(n) = (KINETIC_FRICTION*cos(getTheta)*MASS*GRAVITY*BALLRADIUS)/INERTIA;
                
                if n ==1
                    all_omega(n) = initial_omega;
                else
                    all_omega(n) = all_omega(n-1) + all_alpha(n);
                end
            else
                [deltaPosition, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME, 0);
                all_accelerations(n) = norm(finalVelocity - getOldVelocity(0))/DELTA_TIME;
                all_alpha(n) = all_accelerations(n) / BALLRADIUS;
                all_omega(n) = norm(final_velocity) / BALLRADIUS;
            end

            oldPosition = deltaPosition + oldPosition;
            x(n) = oldPosition(1);
            y(n) = oldPosition(2);
            all_velocities(n) = norm(finalVelocity);
            elasped_time = DELTA_TIME + elasped_time;
            n = n + 1;
            setOldVelocity(finalVelocity(1), finalVelocity(2));
        end

    else % moving from left to right
        while  oldPosition(1) < final_position(1)
            if STATIC_FRICTION < abs((2/7)*tan(getTheta()))
                [deltaPosition, finalVelocity, acceleration] = slopeSlipping((getOldVelocity(2))*DELTA_TIME, 0);
               
                all_accelerations(n) = acceleration;
                all_alpha(n) = (KINETIC_FRICTION*cos(getTheta)*MASS*GRAVITY*BALLRADIUS)/INERTIA;
                
                if n ==1
                    all_omega(n) = initial_omega;
                else
                    all_omega(n) = all_omega(n-1) + all_alpha(n)*DELTA_TIME;
                end
            else
                [deltaPosition, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME,1);
                all_accelerations(n) = norm(finalVelocity - getOldVelocity(0))/DELTA_TIME;
                all_alpha(n) = all_accelerations(n) / BALLRADIUS;
                all_omega(n) = norm(finalVelocity) / BALLRADIUS;
            end

            oldPosition = deltaPosition + oldPosition
            x(n) = oldPosition(1);
            y(n) = oldPosition(2);
            all_velocities(n) = norm(finalVelocity);
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
    omegas(1) = all_omega(1);
    alphas(1) = all_alpha(1);

    for idx = 2:(numOfPoints)
        velocities(idx) = all_velocities(idx*increment);
        accelerations(idx) = all_accelerations(idx*increment);
        x_positions(idx) = x(idx*increment);
        y_positions(idx) = y(idx*increment);
        omegas(idx) = all_omega(idx*increment);
        alphas(idx) = all_alpha(idx*increment);
        
    end
    omegaFinal = omegas(length(omegas));
    finalPosition = [x(length(x)), y(length(y))];


end %function end



