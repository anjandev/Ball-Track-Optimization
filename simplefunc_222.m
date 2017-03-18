clear all
clc
close all


position = ones(1,20);
time = ones(1,20);

x = linspace(0,10,1000);

% {L} = Meters 
r = 1;
delta_time = 0.01;

theta = pi/4;
old_velocity = [5,2];




function [position, final_velocity] = slope_noslipping(theta, old_velocity)

w = length(old_velocity)/r;

% if y2<y1 ====> -sin(theta)
% to do: make sure direction is right

new_velocity = length(old_velocity)*[cos(theta), -sin(theta)];
delta_y= (old_velocity(2))*delta_time;

wf = ((m*w^2*r^2 + I*w^2 + 2*m*g*(delta_y))/(m*r^2+I))^0.5;

final_velocity = wf*r*[cos(theta), -sin(theta)];

position = old_velocity*delta_time;
final

end