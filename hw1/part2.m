%Go to goal
%---------------------------------------------------------------------------------
%|Go to goal
%|
%----------------------------------------------------------------------------------
clear
close all
clc

%% Parameters

% Workspace Size

xlim([0 200])
ylim([0 200])

% Initial Orientation
theta = randomNum(0,2*pi);
%Initialize positions for the robot
p1.x = 100;
p1.y = 100;
p1.theta = theta;


%final position
finalPos.x=randomNum(0,200);
finalPos.y=randomNum(0,200);

%% Robot Initial Pose

% init Robot Model


%get transfotmed & rotated from part 1
movement = [20 30 0];

[initPos.x,initPos.y] = moveRotate([p1.x,p1.y],movement);
initPos.theta = theta ;
initRobot = recBot(initPos.x,initPos.y,initPos.theta+movement(3));


% finalPos.x= initPos.x - 30;
% finalPos.y=initPos.y;
%get final Robot Model
finalRobot = recBot(finalPos.x,finalPos.y,theta+movement(3));
%recBot(finalPos.x,finalPos.y,theta+movement(3))
x = [];
y = [];


x(1) = initPos.x;
y(1) = initPos.y;
theta_list(1) = theta;
%thetaD=atan2((finalPos.y-y(1)),(finalPos.x- x(1)));

%disp(sprintf('atan2 =%f',thetaD));


%prepare for moving to goal.
Kv=0.1;
Kp=0.9;
maxVel = 5;
maxSteer = pi/4;

%time step
dt = 0.1;
%number of steps of the simualtion
nstep = 1000;
i = 1;
stopFlag = 0;
runningVel = 0;



fig=figure(1);
set(fig,'position',[100 100 800 800]);
f1=subplot(4,2,[1,2,3,4]);




f2=subplot(4,2,7);

f3=subplot(4,2,8);
vlist = [];
vlist(1) = 0;

vel_idx=1;
while 1
    %% Calculate thetaD,theta diff, kp,kv.
    
    d=sqrt((finalPos.x-x(i))^2+(finalPos.y-y(i))^2);
    
    thetaD=atan2((finalPos.y-y(i)),(finalPos.x- x(i)));
    if thetaD>=pi
            thetaD=thetaD-2*pi;
    elseif thetaD<= 0 %XXX
            thetaD=thetaD+2*pi;
    end
    
    
    theta_diff=thetaD-theta_list(i);

    runningVel = Kv*d;
    runningTheta =Kp *theta_diff;
    if runningVel > maxVel
        runningVel = maxVel;
    elseif runningVel < -maxVel
        runningVel = -maxVel;
    end
    
    if runningTheta > maxSteer
        runningTheta = maxSteer;
    elseif runningTheta < -maxSteer
        runningTheta = -maxSteer;
    end
     
    %% update
    if d <= 0.5
        runningVel =0;
        stopFlag = 1;
    end
    
    
    x(i+1) = x(i) + runningVel * cos(theta_list(i)) * dt;
    y(i+1) = y(i) + runningVel * sin(theta_list(i)) * dt;
    theta_list(i+1) = theta_list(i) + runningTheta * dt;
    
    
   
    robot = recBot(x(i),y(i),theta_list(i));
    subplot(4,2,[1,2,3,4]);

    axis([0 200 0 200]);
    xlim([0 200])
    ylim([0 200])
    plot(robot(1,1),robot(1,2),'r.',robot(1:2,1),robot(1:2,2),'r-',robot(3:end,1),robot(3:end,2),'-',x,y,'-');
    text(x(i)+10, y(i)+10, sprintf('(%.3f,%.3f, vel:%.3fm/s)', x(i),y(i),runningVel));
    

    hold on
    
    
    plot(initRobot(1,1),initRobot(1,2),'r.',initRobot(1:2,1),initRobot(1:2,2),'r-',initRobot(3:end,1),initRobot(3:end,2),'b-');
    plot(finalPos.x,finalPos.y,'bx'); plot(finalPos.x,finalPos.y,'bo');
    text(finalPos.x+10, finalPos.y, sprintf('(%f,%f)', finalPos.x,finalPos.y));
    hold off
    xlim([0 200])
    ylim([0 200])
    axis square;
    

%   
    %% plot vel
    subplot(4,2,7);
    axis( [0 650 0 5.5]);
    hold on
%     if mod(i,10)==0
        vlist(vel_idx+1)=runningVel;
        if vel_idx == 1
            plot(0,0,'b');
        else
            plot(vel_idx-1,vlist(vel_idx+1),'b-');
        end 
        vel_idx = vel_idx + 1;  
%     end
    plot(vlist,'b-');
    hold off
    
    subplot(4,2,8);
    axis( [0 650 0 210]);
    hold on
    plot(x,'b-');
    plot(y,'r-');
    
    hold off



    
    if stopFlag == 1
        break
    end
    i = i+1;
    


    pause(0.01)
    %disp(i)
    
end

%     plot(initRobot(3:end,1),initRobot(3:end,2),'-',initRobot(1,1),initRobot(1,2),'r-');
%     text(initPos.x+10, initPos.y, sprintf('(%f,%f)', initPos.x,initPos.y));

 

%plot init and final pos
% 
% plot(initRobot(3:end,1),initRobot(3:end,2),'-');
% plot(initRobot(1:2,1),initRobot(1:2,2),'r-');
% plot(initRobot(1,1),initRobot(1,2),'r.');

%text(initPos.x+10, initPos.y, sprintf('(%f,%f)', initPos.x,initPos.y));

% plot(finalRobot(3:end,1),finalRobot(3:end,2),'-');
% plot(finalRobot(1:2,1),finalRobot(1:2,2),'r-');
% plot(finalRobot(1,1),finalRobot(1,2),'r.');
% text(finalPos.x+10, finalPos.y, sprintf('(%f,%f)', finalPos.x,finalPos.y));
% 
% plot(finalPos.x,finalPos.y,'x')
% hold off

