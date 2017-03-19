% Global Variable functions
% setOldVelocity(x,y)
% getOldVelocity(0) = velocity component in(x,y)
% getOldVelocity(1) = x velocity only
% getOldVelocity(2) = y velocity only
% getOldVelocity(3) = magnitude 
% setTheta(theta) %%setting the angle
% getTheta() %%gets the theta value

% TODO: CHECK ALL UNITS

clc
clear all
close all

global GRAVITY BALLRADIUS INERTIA DELTA_TIME MASS
GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 

% Decrase for precision
DELTA_TIME = 0.01;

%initial velocity. Decrease for precision
setOldVelocity(0.01,0.01);
%ramp angle
setTheta(pi/4);
%graph size, 36inch to meter
xyMax = 0.9144; % converted inches to m


oldPosition = [0,0];
on = 1; %gets out of the while loop
n = 1; %timer counter
timer = 0;
while on == 1;
    [position, finalVelocity] = slopeNoSlipping;
    oldPosition = position + oldPosition;
    
    %%  Graphical Simulation
    % Stopped graphical simulation because for precise calculation,
    % the graph is waiting for the computer to compute the values
    % and it doesnt show the actual movement of the ball. 
    % Graphical simulation only shows a decent representation of motion 
    % when the calculation is not precise.
    
    
    %Position Simulation
    subplot(3,1,1)
    plot(oldPosition(1),oldPosition(2),'o');
    axis([0,xyMax,-xyMax,0]);
    T_disp = timer; 
    title('Velocity vs Time')
    xlabel(['Time (s)       ''Current Time: ' num2str(T_disp) 's'])
    ylabel('y position')
    
    %Velocity Simulation
    subplot(3,1,2)
    plot(n*DELTA_TIME,norm(finalVelocity),'o')
    hold on;
    V_disp = norm(finalVelocity);
    title('Velocity vs Time')
    xlabel(['Time (s)       ''Current Velocity: ' num2str(V_disp) 'm/s'])
    ylabel('Velocity (m/s)')
    
    %Acceleration Simulation
    subplot(3,1,3)
    hold on;
    plot(n*DELTA_TIME,(norm(finalVelocity)-getOldVelocity(3))/DELTA_TIME,'o')
    title('Acceleration vs Time')
    xlabel('Time (s)')
    ylabel('Acceleration (m/s^2)')
    
    pause(DELTA_TIME);

    %% Calculation of Velocities and Positions
    %timer counter
    n = n+1;
    timer = (n+1)*DELTA_TIME;
    %keeping track of position and velocity
    setOldVelocity(finalVelocity(1),finalVelocity(2));
    velocity = getOldVelocity(0);
    %exiting the while loop and displying final vectors
    if abs(oldPosition(1))>xyMax |oldPosition(1)<-1 ||oldPosition(2)> 1 | abs(oldPosition(2))>xyMax
        final_Position = oldPosition;
        final_Velocity = velocity;
        timer = n*DELTA_TIME;
        on = 0;
    end
end
TimeResult = sprintf('Time To Completion: %d s', timer)
disp('Final Velocity')
disp('   V_x      V_y')
disp(final_Velocity)

