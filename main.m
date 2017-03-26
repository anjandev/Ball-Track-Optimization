clear all
close all
clc

global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME STATIC_FRICTION KINETIC_FRICTION

% Kinetic friction is less thann static friction
KINETIC_FRICTION = 0.1;
STATIC_FRICTION = 0.1;

GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 


DELTA_TIME = 0.001; % Smaller DELTA time increases precision of slope calculation
PLOT_TIME = 0.05; % Plot every ___ Seconds

velocity = [0.01, -0.01];
time = 0;
position = [0, 0];
omega = 0;
slope_angle = pi/6;
final_slope_position = [3, 3];

addpath './curves'
addpath './objects'

%[x_positions, y_positions, velocities, accelerations, time, finalPosition] = brachistochrone(velocity, 2, position, time, omega);
[x_positions, y_positions, velocities, accelerations, time, finalPosition, omega, alpha] = slope(velocity, position, time, [0.916,-0.64771], omega);
plotFunction(x_positions, y_positions, velocities, accelerations, time, [36, -36]);


Time_taken = time;


disp('Final Velocity (m/s)')
disp('   V_x      V_y')
disp(getOldVelocity(0))
