% Global Variable functions
% setOldVelocity(x,y)
% getOldVelocity(0) = velocity component in(x,y)
% getOldVelocity(1) = x velocity only
% getOldVelocity(2) = y velocity only
% getOldVelocity(3) = magnitude 

% setTheta(theta) %%setting the angle
% getTheta() %%gets the theta value

clc
clear all
close all

global GRAVITY BALLRADIUS INERTIA DELTA_TIME MASS
GRAVITY = -9.81;
BALLRADIUS = 1;
MASS = 1;
INERTIA = (2/5)*MASS*BALLRADIUS^2; 
DELTA_TIME = 0.01;

%initial velocity
setOldVelocity(1,1);
%ramp angle
setTheta(pi/4);


oldPosition = [0,0];
on = 1; %gets out of the while loop
n = 1; %timer counter
while on == 1;
[position, finalVelocity] = slopeNoSlipping;
oldPosition = position + oldPosition;
plot(oldPosition(1),oldPosition(2),'o');

%setting graph size
xyMax = 36;
axis([0,xyMax,-xyMax,0]);
pause(DELTA_TIME);

%timer counter
n = n+1;
%keeping track of position and velocity
setOldVelocity(finalVelocity(1),finalVelocity(2));
velocity = getOldVelocity(0);
%exiting the while loop and displying final vectors
if abs(oldPosition(1))>xyMax |oldPosition(1)<-1 ||oldPosition(2)> 1 | abs(oldPosition(2))>xyMax
    final_Position = oldPosition
    final_Velocity = velocity
    timer = n*DELTA_TIME
    on = 0;
end
end

