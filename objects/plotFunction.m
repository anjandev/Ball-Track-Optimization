function plotFunction(x_positions, y_positions, velocities,...
                        accelerations, final_time, finalPosition)

    global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME

    %% FUNCTION-EXCLUSIVE PARAMETERS
    xyMax = finalPosition(1);                    
    v_Max = velocities(length(velocities));
    a_Max = accelerations(length(accelerations));
    t_int = linspace(0, final_time, length(velocities));

    %% PLOT POSITION
    subplot(2,2,1);
    plot(x_positions,y_positions,'*')
    % axis([0,xyMax,-xyMax,0]);
    T_disp = final_time;
    title(['Position vs Time,    ',num2str(DELTA_TIME),'s per increment'])
    xlabel(['Time (s)       ' 'Current Time: ' num2str(T_disp) 's'])
    ylabel('y position')

    %% PLOT VELOCITY VS TIME 

    subplot(2,2,2);
    plot(t_int, velocities)
    title('Velocity vs Time')
    xlabel('Time (s)');
    ylabel('Velocity (m/s)')

    %% PLOT ACCELERATION VS TIME 
    subplot(2,2,3);
    plot(t_int, accelerations)
    title('Acceleration vs Time');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');


