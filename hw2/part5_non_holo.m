close all;
clear all;


qGoal  = [80;20];
qStart =[10;80];
VMAX = 5;
ANGLEMAX=pi/4;
x = [];
y = [];
theta = [];
x(1) = qStart(1);
y(1) = qStart(2);
theta(1) = 0;
% theta = [];
% theta(1) = 0;
meanX = mean([30,50,50,30]);
meanY = mean([50,50,70,70]);
obstacle = [meanX, meanY];

epsilon = 1;
eta = 80;
rho_0 = 20;
stopFlag = 0;
dt = 0.1;
i = 1;

%% initial plot
[initX,initY]=meshgrid(1:2:100.,1:2:100);
[initF_att_X,initF_att_Y] = Fatt(initX, initY, qGoal,epsilon);
%% rep
[initFrep_X,initFrep_Y] = get_Frep(initX,initY,obstacle,eta,rho_0);

initF_sum_X = initF_att_X + initFrep_X;
initF_sum_Y = initF_att_Y + initFrep_Y;

hold on


quiver(initX,initY,initF_sum_X,initF_sum_Y);
text(qGoal(1)+5,qGoal(2), sprintf('goal:(%.3f,%.3f)',qGoal(1),qGoal(2)) );

plot(qGoal(1),qGoal(2),'ro');
text(obstacle(1)+5,obstacle(2), sprintf('obstacle:(%.3f,%.3f)',obstacle(1),obstacle(2) ));
plot(obstacle(1),obstacle(2),'gx');
plot(qStart(1),qStart(2),'rx');
initRobot = recBot(x(1),y(1),theta(1));
plot(initRobot(1,1),initRobot(1,2),'r.',initRobot(1:2,1),initRobot(1:2,2),'r-',initRobot(3:end,1),initRobot(3:end,2),'--');
text(x(1)+5,y(1), sprintf('start:(%.3f,%.3f)', x(1),y(1)) );
xlim([0 100]);
ylim([0 100]);
axis square;



Kv=2;
Kp = 2;
while 1
    
    %% F att & F rep
    [F_att_X,F_att_Y] = Fatt(x(i), y(i), qGoal,epsilon);
    [Frep_X,Frep_Y] = get_Frep(x(i),y(i),obstacle,eta,rho_0);
    F_sum_X = F_att_X + Frep_X;
    F_sum_Y = F_att_Y + Frep_Y;
    

    %% Update x,y & vel
    dist=sqrt((qGoal(1)-x(i))^2+(qGoal(2)-y(i))^2);
    
    thetaD = atan2(F_sum_Y,F_sum_X);
    theta_diff = atan2( sin(thetaD-theta(i)),cos(thetaD-theta(i) ));
  
    runningVel = Kv*dist;
    if runningVel >= 5.0
        runningVel = VMAX;
    elseif runningVel <=-5.0
        runningVel = - VMAX;
    end
    
    runningAngle = Kp * theta_diff;
    if runningAngle > ANGLEMAX
        runningAngle = ANGLEMAX;
    elseif runningAngle <- ANGLEMAX
        runningAngle = -ANGLEMAX;
    end
    
    
    if dist <= 1
        runningVel =0;
        stopFlag = 1;
        F_sum_X = 0;
        F_sum_Y = 0;
    end
    
    x(i+1) = x(i) + runningVel * cos(theta(i)) * dt;
    y(i+1) = y(i) + runningVel * sin(theta(i)) * dt;
    theta(i+1) = theta(i) + runningAngle * dt;
 

    if stopFlag == 1
        break
    end
    
    disp(runningVel);
    i = i+1;
    
%         pause(0.01)
    
   
    
end
hold on
finalRobot = recBot(x(end),y(end),theta(end));

plot(finalRobot(1,1),finalRobot(1,2),'r.',finalRobot(1:2,1),finalRobot(1:2,2),'r-',finalRobot(3:end,1),finalRobot(3:end,2),'-');
plot(x,y,'r.');
title("non-holonomic robot");
xlim([0 100]);
ylim([0 100]);
axis square;

 



