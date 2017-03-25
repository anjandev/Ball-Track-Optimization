function[positionChange, finalVelocity, acceleration] = slopeSlipping()

    global GRAVITY DELTA_TIME KINETIC_FRICTION MASS BALLRADIUS INERTIA MOVING_RIGHT MOVING_LEFT
    
    acceleration = -GRAVITY*sin(getTheta) + KINETIC_FRICTION*GRAVITY*cos(getTheta);
    
    finalVelocity = getOldVelocity(0) + acceleration*DELTA_TIME*[cos(getTheta),-sin(getTheta)];
    
    positionChange = getOldVelocity(0)*DELTA_TIME + (1/2)*acceleration*DELTA_TIME^2;
    %omega = alpha*DELTA_TIME
    %alpha = (K_FRICTION*cos(getTheta)*MASS*GRAVITY*BALLRADIUS)/INERTIA 
end


