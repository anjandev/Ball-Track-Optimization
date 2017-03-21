clear all
close all
clc

global GRAVITY BALLRADIUS INERTIA DELTA_TIME MASS
GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 

% Decrase for precision
DELTA_TIME = 0.01;

CURVE_SIZE = 14; % Scales brachistochrone curve
DIVISIONS = 10000;
t = linspace(0, pi, DIVISIONS); %%define t for parametric equations (1000 divisions)

x = (CURVE_SIZE)*(t-sin(t)); %% x equation
y = (CURVE_SIZE)*(-1+cos(t)); %% y equation

% Plot the Brachistochrone curve
plot(x,y)

%% Find Slopes 
% I can do this two ways, I can either use equation or just do
% delta y/delta x

slopes_theta = atan2(y, x);
%% Set slopes and calculate velocity

setOldVelocity(0.01,0.01);
oldPosition = [0,0];


elapsedTime = 0;
velocities = 1:length(slopes_theta);
accelerations = 1:length(slopes_theta);

for idx = 1:length(slopes_theta)
    setTheta(slopes_theta(idx));
    
    [delta_position, finalVelocity] = slopeNoSlipping;
    
    % In the original slope algorithm, we used 
    % delta_position = delta_time * velocity from slopeNoSlipping function
    % for position. Then, we checked at the end if it had reached the end.
    % For the brachistochrone, we know the points positions and calculate
    % the average time it would take the point to reach the next point
    
    
    if idx == 1
        velocities(idx) = norm(finalVelocity);
    else
        velocities(idx) = norm(finalVelocity);
        delta_time = norm([x(idx) - x(idx -1), y(idx) - y(idx -1)]) / norm(finalVelocity);
        accelerations(idx) = getOldVelocity(3) / (delta_time);
        elapsedTime = delta_time + elapsedTime;
        
    end

    setOldVelocity(finalVelocity(1),finalVelocity(2));
    
end