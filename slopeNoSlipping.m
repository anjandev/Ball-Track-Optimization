function [position, finalVelocity] = slopeNoSlipping()
    global BALLRADIUS GRAVITY INERTIA MASS DELTA_TIME
    
    mag_oldVel = getOldVelocity(3)

    omega = mag_oldVel / BALLRADIUS;
    newVelocity = (omega*BALLRADIUS)*[cos(getTheta), -sin(getTheta)];
    deltaY = (getOldVelocity(2))*DELTA_TIME;

    omegaFinal = ((MASS*omega^2*BALLRADIUS^2 + INERTIA*omega^2 + 2*MASS*GRAVITY*deltaY)/(MASS*BALLRADIUS^2+INERTIA))^0.5;
    finalVelocity = (omegaFinal*BALLRADIUS)*[cos(getTheta),-sin(getTheta)];

    %finalVelocity = ((MASS*getOldVelocity(3)^2 + INERTIA*omega^2 + 2*MASS*GRAVITY*deltaY)/(MASS+INERTIA*1/BALLRADIUS^2))^0.5;
    %finalVelocity = finalVelocity*[cos(getTheta),-sin(getTheta)];


    position = getOldVelocity(0)*DELTA_TIME;

end