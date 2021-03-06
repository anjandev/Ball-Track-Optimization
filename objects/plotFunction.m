function plotFunction(x_positions, y_positions, velocities,...
                        accelerations, final_time, alphas, omegas, finalPosition)

    global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME

    %% FUNCTION-EXCLUSIVE PARAMETERS
    xyMax = finalPosition(1);                    
    v_Max = velocities(length(velocities));
    a_Max = accelerations(length(accelerations));
    t_int = linspace(0, final_time, length(alphas));

    %% PLOT POSITION
    subplot(2,3,1);
    plot(x_positions,y_positions,'*')
    % axis([0,xyMax,-xyMax,0]);
    T_disp = final_time;
    title(['Position vs Time,    ',num2str(PLOT_TIME),'s per increment'])
    xlabel(['Time (s)       ' 'Current Time: ' num2str(T_disp) 's'])
    ylabel('y position')

    %% PLOT VELOCITY VS TIME 

    subplot(2,3,2);
    plot(t_int, velocities)
    title('Velocity vs Time')
    xlabel('Time (s)');
    ylabel('Velocity (m/s)')

    %% PLOT ACCELERATION VS TIME 
    subplot(2,3,3);
    plot(t_int, accelerations)
    title('Acceleration vs Time');
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    axis([-inf,inf,0,20])


    %% PLOT ANGULAR ACCELERATION VS TIME 
    subplot(2,3,4);
    plot(t_int, alphas)
    title('Angular Acceleration vs Time');
    xlabel('Time (s)');
    ylabel('Angular Acceleration (rad/s^2)');

    %% PLOT ANGULAR VELOCITY VS TIME 
    subplot(2,3,5);
    plot(t_int, omegas)
    title('Angular Velocity vs Time');
    xlabel('Time (s)');
    ylabel('Angular Velocity (rad/s)');