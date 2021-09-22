%transformatino and rotate the robot
%---------------------------------------------------------------------------------
%| Test homogeneous transformation
%| 1. init a TriangularRobot point at 
%| some where based on cur center position, 
%| 2. move the robot to x=20, y=30, angule= pi/6 (by calling functio: moveRotate)
%| 3. Draw init and final position
%----------------------------------------------------------------------------------
clear
close all
clc

%% Parameters

% Workspace Size

xlim([0 200])
ylim([0 200])


%Initialize a vector of positions for the robot
x=[]; 
y=[];

%% Robot Initial Pose

x(1) = 100;
y(1) = 100;

% Initial Orientation
theta(1) = randomNum(0,2*pi);

% init Robot Model
initRobot = recBot(x,y,theta(1));


%get transfotmed & rotated
movement = [20+x 30+y pi/6+theta(1)];
% [finalX,finalY] = moveRotate([x(1),y(1)],[20, 30, pi/6]);

%get final Robot Model
finalRobot = recBot(movement(1),movement(2),movement(3));
% finalRobot = recBot(finalX,finalY,pi/6);

%plot init and final pos
hold on
grid on
xlabel('x [m]');ylabel('y [m]')
plot(initRobot(3:end,1),initRobot(3:end,2),'--');
plot(initRobot(1:2,1),initRobot(1:2,2),'r-');
plot(initRobot(1,1),initRobot(1,2),'r.');

text(x(1)+10, y(1), sprintf('(%d,%d,%f )', x(1),y(1),theta(1)));
str = sprintf("HW1 Part1");
title(str );
plot(finalRobot(3:end,1),finalRobot(3:end,2),'-');
plot(finalRobot(1:2,1),finalRobot(1:2,2),'r-');
plot(finalRobot(1,1),finalRobot(1,2),'r.');
text(movement(1)+10, movement(2), sprintf('(%d,%d, %f)', movement(1),movement(2),movement(3)));
% text(finalX+10, finalY, sprintf('(%d,%d, %f)', finalX,finalY,movement(3)));

legend("Before","","","After");
xlim([0 200])
ylim([0 200])
axis square;
hold off





    