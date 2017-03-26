function[positionChange, finalVelocity, acceleration] = slopeSlipping(deltaPosition, isBrach)

    global GRAVITY DELTA_TIME KINETIC_FRICTION MASS BALLRADIUS INERTIA MOVING_RIGHT MOVING_LEFT
    
    acceleration = GRAVITY*sin(getTheta()) + KINETIC_FRICTION*GRAVITY*cos(getTheta());
    
    if(isBrach)
        delta_time = norm(deltaPosition) / norm([getOldVelocity(1), getOldVelocity(2)]);
        finalVelocity = getOldVelocity(0) + acceleration*delta_time*[cos(getTheta()),sin(getTheta())];
        positionChange = getOldVelocity(0)*delta_time + (1/2)*acceleration*[cos(getTheta()),sin(getTheta())]*delta_time^2;
    else
        finalVelocity = getOldVelocity(0) + acceleration*DELTA_TIME*[cos(getTheta()),sin(getTheta())];
        positionChange = getOldVelocity(0)*DELTA_TIME + (1/2)*acceleration*[cos(getTheta()),sin(getTheta())]*DELTA_TIME^2; 
    end
    %omega = alpha*DELTA_TIME
    %alpha = (K_FRICTION*cos(getTheta)*MASS*GRAVITY*BALLRADIUS)/INERTIA 
end


