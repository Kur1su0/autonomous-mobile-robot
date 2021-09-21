function [a,b,c] = get_user_click(isClick)
% function theta = measureAngle
% Get four mouse clicks from the user in the current figure
if isClick==1
    [p1,p2] = ginput(2);
else
    p1=[randomNum(0,200) randomNum(0,200)];
    p2=[randomNum(0,200) randomNum(0,200)];
end
% Draw the two lines that the four points represent

%line(p1(1:2), p2(1:2));
% Define the two vectors

x = [p1(1) p1(2)];
y = [p2(1) p2(2)];
cc = [[1; 1]  x(:)]\y(:);

slope_m = cc(2)
intercept_b = cc(1)
a = -1 * slope_m;
b = -1;
c =  intercept_b;

%y = (-a*x + c)/b;
end
