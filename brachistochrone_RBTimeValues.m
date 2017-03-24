%% DESCRIPTION

%CHECKS THE MOST TIME EFFICIENT CURVE
% GIVES R, B, AND TIME FOR GIVEN X AND Y

%WHERE%
%R IS THE COEFFICIENT FOR Y; MUST BE NEGATIVE!
%B IS THE COEFFICIENT FOR X; ALWAYS POSITIVE

%NOTES:
% didn't declare gravitational acceleration as as constant >.>
% must use (1-cost) for y, not (-1+cost)

close all
clear all
clc

%% DECLARE END COORDINATES
X = 0.9144;
Y = -1.5;

theta = atan(abs(Y/X));

%% GRAPH SPECIFICATIONS
%STEPSIZE
n = 0.01; %(0.1*pi to 1.9*pi; excluding 0 and 2PI)

% DIVISIONS
DIV_INTERVAL = (2/n)-1; %-1 to exlude 0 and 2PI

%% VECTORS

% VECTORS THAT HOLD R,B,TIME, AND PARAMETRIC VAR VALUES
R_VECT = zeros(1,DIV_INTERVAL); %(R)
B_VECT = zeros(1,DIV_INTERVAL); %(B)
T_VECT = zeros(1,DIV_INTERVAL); %(TIME)
smallT_VECT = zeros(1,DIV_INTERVAL); %t, parametric variables

%% PROCESS

CURRENT_STEP = 0;

for i = 1:DIV_INTERVAL

CURRENT_STEP = CURRENT_STEP + n;

%CHOOSE T (FROM 0<t<2PI)
t = CURRENT_STEP*pi;

% CALCULATE R VALUE 
R = Y./(1-cos(t));
% CALCULATE B VALUE;
B = X./(t-sin(t));

%if the error is below 5%
if abs(abs(B)-abs(R))<0.05
    time = abs(sqrt(B/7.007).*t);
else % derived formula
    f =@(x)(B/R)*(1/(sqrt(10/7*9.81)))*sqrt((B^2.*x+2*R^3-R^2.*x)./(2*B^2*R.*x-(B.^2)*x.^2));
    time = abs(integral(f,0,4));
end

% store values to vectors
R_VECT(i) = R;
B_VECT(i) = B;
T_VECT(i) = time;
smallT_VECT(i) = t;
end

%% Extract smallest time + index. Use index to get corresponding 
[M,I] = min(T_VECT);
R_FINAL = R_VECT(I);
B_FINAL = B_VECT(I);
T_FINAL = T_VECT(I);
SMALLT_FINAL =smallT_VECT(I);
PI_COEFF = SMALLT_FINAL/pi;

%% CALCULATE THEORETICAL SLOPE TIME (using energy equation)

T_SLOPE = sqrt(2*9.81*abs(Y))/(9.81*sin(theta));

%% OUTPUT

sprintf('EFFICIENT R VALUE: %f \n' ,R_FINAL),
sprintf('EFFICIENT B VALUE: %f \n' ,B_FINAL),
sprintf('TIME ELAPSED: %f \n' ,T_FINAL),
sprintf('TIME ELAPSED FOR SLOPE: %f \n' ,T_SLOPE),
sprintf('PI COEFFICENT: %f \n' ,PI_COEFF),

% LOL IT'S THE SAME VALUE AS X ABOVE
endCoordinate_X = B_FINAL.*(SMALLT_FINAL-sin(SMALLT_FINAL));

% create vector parametric inputs (t)
t = linspace(0,SMALLT_FINAL,1000);

% create vector of x inputs
t2 = linspace (0, endCoordinate_X,1000);

% PARAMETRIC EQUATIONS
x = B_FINAL.*(t-sin(t));
y = R_FINAL.*(1-cos(t));

%RECTANGULAR COORDINATE FUNCTION
%WHERE Y/X IS THE SLOPE (MUST START AT (0,0)).
z=(Y/X)*t2;

% subplot(2,1,1)
plot(x,y)
hold on
plot(t2,z)
