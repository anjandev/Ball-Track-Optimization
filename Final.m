clc
clear all
close all

global GRAVITY BALLRADIUS INERTIA DELTA_TIME MASS xyMax
GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 

DELTA_TIME = 0.01;


setOldVelocity(0.01,-0.01);
setTheta(pi/2);
xyMax =  4  %0.9144; % converted inches to m

oldPosition = [0,0];




n = 1; %timer counter
timer = 0;
%% Brachisochrone

CURVE_SIZE = 1.40; % Scales brachistochrone curve
DIVISIONS = 1000;
t = linspace(0, pi, DIVISIONS); %%define t for parametric equations (1000 divisions)

x = (CURVE_SIZE)*(t-sin(t)); %% x equation
y = -(CURVE_SIZE)*(-1+cos(t)); %% y equation

%% Find Slopes 
% I can do this two ways, I can either use equation or just do
% delta y/delta x
slopes_theta = 1:(length(y)-1);

for idx = 1:length(y)-1
    slopes_theta(idx) = atan2(y(idx+1)-y(idx), x(idx+1)-x(idx));
end

%% Setting up velocity and acceleration
elapsedTime = 0;
velocities = 1:length(slopes_theta);
accelerations = 1:length(slopes_theta);

%%

    while oldPosition(2) > -0.31348 
        [position, finalVelocity] = slopeNoSlipping((getOldVelocity(2))*DELTA_TIME);
        oldPosition = position + oldPosition;
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
                
    %% Calculation of Velocities and Positions
    %keeping track of position and velocity
    setOldVelocity(finalVelocity(1),finalVelocity(2));
    velocity = getOldVelocity(0);

    n = n+1;
    timer = (n)*DELTA_TIME;
    end
final_Velocity = velocity

%while oldPosition(1) < 0.695 && oldPosition(2) > - 0.785
    
for idx = 1:length(slopes_theta)
    setTheta(slopes_theta(idx));
    [delta_position, finalVelocity] = slopeNoSlipping((y(idx+1) - y(idx)));
    
    if idx == 1
        velocities(idx) = norm(finalVelocity);
    else
        velocities(idx) = norm(finalVelocity);
        delta_time = norm([x(idx) - x(idx -1), y(idx) - y(idx -1)]) / norm(finalVelocity);
        accelerations(idx) = getOldVelocity(3) / (delta_time);
        elapsedTime = delta_time + elapsedTime + timer; % added timer
        
        setOldVelocity(finalVelocity(1),finalVelocity(2));
        oldPosition = delta_position + oldPosition
    
   
    subplot(3,1,1)
    hold on;
    plot(oldPosition(1),oldPosition(2),'o');
    %axis([0,xyMax,-xyMax,0]);
    T_disp = timer; 
    title(['Position vs Time,    ',num2str(DELTA_TIME),'s per increment'])
    xlabel(['Time (s)       ' 'Current Time: ' num2str(T_disp) 's'])
    ylabel('y position')
    pause(DELTA_TIME);
        
    if oldPosition(1) > 0.5 && oldPosition(2) < - 0.785
        break;
    end 
 %   end

    
end
   
end
    
TimeResult = sprintf('Time To Completion: %d s', timer)
disp('Final Velocity')
disp('   V_x      V_y')
disp(final_Velocity)

