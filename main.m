clear all
close all
clc

global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME STATIC_FRICTION KINETIC_FRICTION
KINETIC_FRICTION = 0.15;
STATIC_FRICTION = 0.10;

GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 


DELTA_TIME = 0.001; % Smaller DELTA time increases precision of slope calculation
PLOT_TIME = 0.1; % Plot every ___ Seconds

velocity = [0.01, -0.01];
time = 0;
position = [0, 0];
omega = 0;
slope_angle = pi/4;
final_slope_position = [3, 3];

addpath './curves'
addpath './objects'

[x_positions, y_positions, velocities, accelerations, time, finalPosition, omega, alpha] = brachistochrone(velocity, 2, position, time, omega);

plotFunction(x_positions, y_positions, velocities, accelerations, time, [36, -36]);


Time_taken = time;


disp('Final Velocity (m/s)')
disp('   V_x      V_y')
disp(getOldVelocity(0))
