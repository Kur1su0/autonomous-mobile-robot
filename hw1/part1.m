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
max_speed = 5;
max_steering_angle = pi /4;
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
movement = [20 30 pi/6];
[finalX,finalY] = moveRotate([x(1),y(1)],movement)

%get final Robot Model
finalRobot = recBot(finalX,finalY,theta(1)+movement(3));


%plot init and final pos
hold on
plot(initRobot(3:end,1),initRobot(3:end,2),'-');
plot(initRobot(1:2,1),initRobot(1:2,2),'r-');
plot(initRobot(1,1),initRobot(1,2),'r.');

text(x(1)+10, y(1), sprintf('(%f,%f)', x(1),y(1)));

plot(finalRobot(3:end,1),finalRobot(3:end,2),'-');
plot(finalRobot(1:2,1),finalRobot(1:2,2),'r-');
plot(finalRobot(1,1),finalRobot(1,2),'r.');
text(finalX+10, finalY, sprintf('(%f,%f)', finalX,finalY));
hold off


xlim([0 200])
ylim([0 200])




    