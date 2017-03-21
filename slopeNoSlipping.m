function [position, finalVelocity] = slopeNoSlipping(delta_Y)
    global BALLRADIUS GRAVITY INERTIA MASS DELTA_TIME
    
    mag_oldVel = getOldVelocity(3);

    omega = mag_oldVel / BALLRADIUS;    

    omegaFinal = ((MASS*omega^2*BALLRADIUS^2 + INERTIA*omega^2 + 2*MASS*GRAVITY*delta_Y)/(MASS*BALLRADIUS^2+INERTIA))^0.5;
    
    finalVelocity = (omegaFinal*BALLRADIUS)*[cos(getTheta),-sin(getTheta)]; % Second value needs negative sign for slope code TODO

    position = getOldVelocity(0)*DELTA_TIME;
end