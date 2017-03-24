clear all
close all
clc

global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME K_COEF STATIC_FRICTION
K_COEF = 0.1
STATIC_FRICTION = 0.2

GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 


DELTA_TIME = 0.01; % Smaller DELTA time increases precision of slope calculation
PLOT_TIME = 0.1; % Plot every ___ Seconds

velocity = [0.01, -0.01];
time = 0;
position = [0, 0];
omega = 0;

addpath './curves'
addpath './objects'

[x_positions, y_positions, velocities, accelerations, time, finalPosition, omega, alpha] = brachistochrone(velocity, 2, position, time,omega)

plotFunction(x_positions, y_positions, velocities, accelerations, time, finalPosition)

Time_taken = time;


disp('Final Velocity (m/s)')
disp('   V_x      V_y')
disp(getOldVelocity(0))
