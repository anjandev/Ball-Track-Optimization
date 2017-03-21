function graphing()
    %%  Graphical Simulation
    % Stopped graphical simulation because for precise calculation,
    % the graph is waiting for the computer to compute the values
    % and it doesnt show the actual movement of the ball. 
    % Graphical simulation only shows a decent representation of motion 
    % when the calculation is not precise.
    
    
    %Position Simulation
    subplot(3,1,1)
    hold on;
    plot(oldPosition(1),oldPosition(2),'o');
    axis([0,xyMax,-xyMax,0]);
    T_disp = timer; 
    title(['Position vs Time,    ',num2str(DELTA_TIME),'s per increment'])
    xlabel(['Time (s)       ' 'Current Time: ' num2str(T_disp) 's'])
    ylabel('y position')
    
    %Velocity Simulation
    subplot(3,1,2)
    plot(n*DELTA_TIME,norm(finalVelocity),'o')
    hold on;
    V_disp = norm(finalVelocity);
    title('Velocity vs Time')
    xlabel(['Time (s)       ' 'Current Velocity: ' num2str(V_disp) 'm/s'])
    ylabel('Velocity (m/s)')
    
    %Acceleration Simulation
    subplot(3,1,3)
    hold on;
    A_Disp = (norm(finalVelocity)-getOldVelocity(3))/DELTA_TIME;
    plot(n*DELTA_TIME,A_Disp,'o');
    title('Acceleration vs Time');
    xlabel(['Time (s)       ' 'Current Acceleration: ' num2str(A_Disp) 'm/s^2']);
    ylabel('Acceleration (m/s^2)');
    
    pause(DELTA_TIME);


end