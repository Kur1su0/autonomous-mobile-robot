function [robot] = recBot(x,y,theta)

center = [x y];
h = 8;
w = 16;
% Robot triangle shape
 % 8 x 4
 % a     b
 %   dir
 %   X  
 %
 % c     d
a = [-w/2 h/2];
b = [w/2 h/2];
c = [-w/2 -h/2];
d = [w/2 -h/2];

dir = [w*(1/4) 0];
% Rotation Matrix

rotmat = [cos(theta) -sin(theta); sin(theta) cos(theta)];

a = (rotmat * (a'));
b = (rotmat * (b'));
c = (rotmat * (c'));
d = (rotmat * (d'));
dir  =  (rotmat * (dir'));

% Final Robot Configuration after transformation

robot1 =  [a(1) + center(1), a(2) + center(2)];
robot2 =  [b(1) + center(1), b(2) + center(2)];
robot3 =  [c(1) + center(1), c(2) + center(2)];
robot4 =  [d(1) + center(1), d(2) + center(2)];
robot_dir = [dir(1) + center(1), dir(2) + center(2)];

robot = [center;robot_dir;robot1;robot2;robot4;robot3;robot1];
 
end


