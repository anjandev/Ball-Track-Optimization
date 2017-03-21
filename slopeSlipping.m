%slips if F_a<uF_n

%T=I*alpha
%F_f*r=I*alpha
%ucos(theta)mgr/I = alpha

%assuming no slip then
%alpha*r = a
%a*m = F_a

%F_n = cos(thetamg)

% accForceNoSlip = MASS*GRAVITY*sin(getTheta)
% fricForce = K_FRICTION*MASS*GRAVITY*cos(getTheta)
% if accForce < fricForce
%     slopeNoSlipping()
% else
%     slopeSlipping()
% end

% Net Acceleration = Acceleration of Gravity - Friction force/mass
% Final velocity = initial velocity + acceleration*time
% Position = velocity*time + 1/2 at^2
%

function[position,finalVelocity,acceleration] = slopeSlipping()
global GRAVITY DELTA_TIME K_FRICTION
acceleration = GRAVITY*sin(getTheta) - K_FRICTION*GRAVITY*cos(getTheta)
finalVelocity = getOldVelocity(0) + acceleration*DELTA_TIME*[cos(getTheta), -sin(getTheta)]
position = getOldVelocity(0)*DELTA_TIME + (1/2)*acceleration*DELTA_TIME^2
end


