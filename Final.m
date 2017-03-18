% Global Variable functions
% setOldVelocity(x,y)
% getOldVelocity(0) = velocity component in(x,y)
% getOldVelocity(1) = x velocity only
% getOldVelocity(2) = y velocity only
% getOldVelocity(3) = magnitude 

% setTheta(theta)
% getTheta()

clc
clear all
close all

global GRAVITY BALLRADIUS INERTIA DELTA_TIME MASS
GRAVITY = -9.81;
BALLRADIUS = 2;
INERTIA = 3; 
DELTA_TIME = 0.01;
MASS = 3;

setOldVelocity(0.001,0.001);
setTheta(pi/4);

oldPosition = [0,0];
on = 1
while on == 1
[position, finalVelocity] = slopeNoSlipping;
oldPosition = position + oldPosition;
plot(oldPosition(1),oldPosition(2),'O');
hold on;
axis([0,36,-36,0]);
pause(DELTA_TIME);

setOldVelocity(finalVelocity(1),finalVelocity(2))
velocity = getOldVelocity(0)

if oldPosition(1)>36
    on = 0;
end
end

