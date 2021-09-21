function [a,b,c, k , m] = get_user_click(isClick)
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

% (y1 - y2) * x + (x2 - x1) * y + (x1 * y2 - x2 * y1) 
k = cc(2)
m = cc(1)
a = -1 * k;
b = -1;
c =  m;
% a = (p1(2) - p2(2));
% b = (p1(1) - p2(1));
% c = p1(1)*p2(2) - p2(1)*p1(2);

%y = (a*x + c)/(-b);


end

