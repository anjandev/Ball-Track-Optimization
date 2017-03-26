clear all
close all
clc

global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME STATIC_FRICTION KINETIC_FRICTION
KINETIC_FRICTION = 0.15;
STATIC_FRICTION = 0.05;

GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 


DELTA_TIME = 0.001; % Smaller DELTA time increases precision of slope calculation
PLOT_TIME = 0.02; % Plot every ___ Seconds

velocity = [0.01, -0.01];
time = 0;
position = [0, 0];
omega = 0;
slope_angle = pi/4;
end_xposition = 2;
curve_size = 2;

addpath './curves'
addpath './objects'


[x_positions1, y_positions1, velocities1, accelerations1, time, finalPosition,omega, alpha] = slope(velocity, slope_angle, position, time, end_xposition, omega);
[x_positions, y_positions, velocities, accelerations, time, finalPosition, omega, alpha] = brachistochrone(getOldVelocity(0), curve_size, finalPosition, time, omega);

% THIS MUST BE RAN AFTER EACH NEW CURVE AFTER THE FIRST ONE
[x_positions2] = appendToend(x_positions1, x_positions);
[y_positions2] = appendToend(y_positions1, y_positions);
[velocities2] = appendToend(velocities1, velocities);
[accelerations2] = appendToend(accelerations1, accelerations);



%% Setting up all the values for plotting
time_final = time; % Time elasped is already added to the time before in brachistochrone function
% No need to add time

plotFunction(x_positions2, y_positions2, velocities2, accelerations2, time_final, [36, -36]);


disp('Final Velocity (m/s)')
disp('   V_x      V_y')
disp(getOldVelocity(0))
