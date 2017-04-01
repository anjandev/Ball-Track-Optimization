clear all
close all
clc

global GRAVITY BALLRADIUS INERTIA MASS DELTA_TIME PLOT_TIME STATIC_FRICTION KINETIC_FRICTION

% Kinetic friction is less thann static friction
KINETIC_FRICTION = 0.3;
STATIC_FRICTION = 0.4;

GRAVITY = -9.81;
BALLRADIUS = 0.007804912;
MASS = 0.00491240537;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 

BRACH_CURVATURE_VAR = 1; 

DELTA_TIME = 0.001; % Smaller DELTA time increases precision of slope calculation
PLOT_TIME = 0.003; % Plot every ___ Seconds

INCH_TO_METER = 0.0254;
velocity = [0.01, -0.01];
time = 0;
position = [INCH_TO_METER, -INCH_TO_METER];
omega = 0;
slope_angle = pi/6;
final_slope_position = [0, 3];
energy_remain = 0.3;


addpath './curves'
addpath './objects'


[x_positions, y_positions, velocities, accelerations, time, position, omegas, alphas, omega] = slope(getOldVelocity(0), position, time, [1*INCH_TO_METER+position(1), -11*INCH_TO_METER+position(2)], omega);


[x_positions1, y_positions1, velocities1, accelerations1, time, position, omegas1, alphas1, omega] = brachistochrone(getOldVelocity(0), BRACH_CURVATURE_VAR, position, time, omega);

[x_positions2, y_positions2, velocities2, accelerations2, time, position, omegas2, alphas2, omega] = slope(getOldVelocity(0), position, time, [position(1)+ 2*INCH_TO_METER, position(2)], omega);

[x_positions3, y_positions3, velocities3, accelerations3, time, position, omegas3, alphas3, omega] = slope(getOldVelocity(0), position, time, [position(1)+ 7.5*INCH_TO_METER, position(2) + 3*INCH_TO_METER], omega);

[omega,impulse_acceleration] = bounce(energy_remain, getOldVelocity(0));

[x_positions4, y_positions4, velocities4, accelerations4, time, omegas4, alphas4] = free(getOldVelocity(0), time, position,position(1)+ 1*INCH_TO_METER, position(2) + 0.2*INCH_TO_METER,-0.889);
accelerations4(1) = impulse_acceleration;

x_positions = [x_positions x_positions1 x_positions2 x_positions3,x_positions4];
y_positions = [y_positions y_positions1 y_positions2 y_positions3,y_positions4];
velocities = [velocities velocities1 velocities2 velocities3,velocities4];
accelerations = -[accelerations accelerations1 accelerations2,accelerations3,accelerations4];
omegas = [omegas omegas1 omegas2 omegas3,omegas4];
alphas = [alphas alphas1 alphas2 alphas3,alphas4];

plotFunction(x_positions, y_positions, velocities, accelerations, time, alphas, omegas, position);


Time_taken = time;


disp('Final Velocity (m/s)')
disp('   V_x      V_y')
disp(getOldVelocity(0))
