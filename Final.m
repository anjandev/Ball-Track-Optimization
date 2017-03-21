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

n = 1; %timer counter
timer = 0;

%initial velocity. Decrease for precision
setOldVelocity(0.01,-0.01);
%ramp angle
setTheta(pi/2);
%graph size, 36inch to meter
xyMax = 0.9144; % converted inches to m


oldPosition = [0,0];

n = 0;
timer = 0;
velocity = 0;
while 1;
     while oldPosition(2) < -0.31348 
        [position, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME);
        oldPosition = position + oldPosition;
        %%%%
         
    
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

        
        
        
        %graphing()
        %%%
        setOldVelocity(finalVelocity(1),finalVelocity(2));
        velocity = getOldVelocity(0);
            %timer counter
        n = n+1;
        timer = (n)*DELTA_TIME;
     end
        final_Position = oldPosition;
        final_Velocity = velocity;
     %while oldPosition(1) < 0.695 && oldPosition1(2) < - 0.4788
end

TimeResult = sprintf('Time To Completion: %d s', timer)
disp('Final Velocity')
disp('   V_x      V_y')
disp(final_Velocity)
