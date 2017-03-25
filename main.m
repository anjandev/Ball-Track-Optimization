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


[x_positions, y_positions, velocities, accelerations, time, finalPosition,omega, alpha] = slope(velocity, slope_angle, position, time, end_xposition, omega);
n = 1;
for n = 1 : length(x_positions)
    x_positions2(n) = x_positions(n);
    y_positions2(n) = y_positions(n);
    velocities2(n) = velocities(n);
    accelerations2(n) = accelerations(n);
end
%% Getting initial conditions for the next slope
time2 = time;
position_after = [x_positions(length(x_positions)) y_positions(length(y_positions))]
velocity_after = getOldVelocity(0)


[x_positions, y_positions, velocities, accelerations, time, finalPosition, omega, alpha] = brachistochrone(velocity_after, curve_size, position_after, time, omega);

%% Setting up all the values for plotting
for x = 1:(length(x_positions))
    x_positions2(x+n) = x_positions(x);
    y_positions2(x+n) = y_positions(x);
    velocities2(x+n) = velocities(x);
    accelerations2(x+n) = accelerations(x);
end
time_final = time2+time;
%%

%[x_positions, y_positions, velocities, accelerations, time_final, finalPosition, omega, alpha] = brachistochrone(velocity, curve_size, position, time, omega);


plotFunction(x_positions2, y_positions2, velocities2, accelerations2, time_final, [36, -36]);
%plotFunction(x_positions, y_positions, velocities, accelerations, time, [36, -36]);


Time_taken = time;


disp('Final Velocity (m/s)')
disp('   V_x      V_y')
disp(getOldVelocity(0))
