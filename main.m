clear all
close all
clc

global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME
GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 
DELTA_TIME = 0.01; % Smaller DELTA time increases precision of slope calculation
PLOT_TIME = 2; % Plot every ___ Seconds

velocity = [0.01, -0.01];
time = 0;
position = [0, 0];

addpath ./curves
addpath ./objects

[final_position, velocities, accelerations, time] = brachistochrone(velocity, 14, position, time);

Time_taken = time
disp('Final Velocity (m/s)')
disp('   V_x      V_y')
disp(getOldVelocity(3))