close all;
clear all;


qGoal  = [80;20];
qStart =[10;80];
VMAX = 5;
x = [];
y = [];
x(1) = qStart(1);
y(1) = qStart(2);
% theta = [];
% theta(1) = 0;
meanX = mean([30,50,50,30]);
meanY = mean([50,50,70,70]);
obstacle = [meanX, meanY];

epsilon = 1;
eta = 200;
rho_0 = 20;
stopFlag = 0;
dt = 0.1;
i = 1;

%% initial plot
[initX,initY]=meshgrid(1:0.5:100.,1:0.5:100);
[initF_att_X,initF_att_Y] = Fatt(initX, initY, qGoal,epsilon);
%% rep
[initFrep_X,initFrep_Y] = get_Frep(initX,initY,obstacle,eta,rho_0);

initF_sum_X = initF_att_X + initFrep_X;
initF_sum_Y = initF_att_Y + initFrep_Y;

hold on
quiver(initX,initY,initF_sum_X,initF_sum_Y);
plot(qGoal(1),qGoal(2),'ro');
text(qGoal(1)+5,qGoal(2), sprintf('goal:(%.3f,%.3f)',qGoal(1),qGoal(2)) );
plot(obstacle(1),obstacle(2),'gx');
text(obstacle(1)+5,obstacle(2), sprintf('obstacle:(%.3f,%.3f)',obstacle(1),obstacle(2) ));
plot(qStart(1),qStart(2),'rx');
text(x(1)+5,y(1), sprintf('start:(%.3f,%.3f)', x(1),y(1)) );
xlim([0 100]);
ylim([0 100]);
axis square;



Kv=0.3;

while 1
    
    %% F att & F rep
    [F_att_X,F_att_Y] = Fatt(x(i), y(i), qGoal,epsilon);
    [Frep_X,Frep_Y] = get_Frep(x(i),y(i),obstacle,eta,rho_0);
    F_sum_X = F_att_X + Frep_X;
    F_sum_Y = F_att_Y + Frep_Y;
    

    %% Update x,y & vel
    dist=sqrt((qGoal(1)-x(i))^2+(qGoal(2)-y(i))^2);

    theta=atan2(F_sum_Y,F_sum_X);
    runningVel = Kv*dist;
    if runningVel >= 5.0
        runningVel = VMAX;
    elseif runningVel <=-5.0
        runningVel = - VMAX;
    end
    
    if dist <= 2
        runningVel =0;
        stopFlag = 1;
        F_sum_X = 0;
        F_sum_Y = 0;
    end
    
    x(i+1) = x(i) + runningVel * cos(theta) * dt;
    y(i+1) = y(i) + runningVel * sin(theta) * dt;
 

    if stopFlag == 1
        break
    end
    if i<100
        disp(runningVel);
    end
    disp(dist);
    i = i+1;
    
    
    
    plot(x,y,'r.');
    xlim([0 100]);
    ylim([0 100]);
    axis square;
    pause(0.01)
    
end









% %% show contour
% subplot(1,3,1)
% contour_num = 40;
% hold on;
% contour(X,Y,U_sum,contour_num);
% plot(qGoal(1),qGoal(2),'rx');
% plot(obstacle(1),obstacle(2),'bx');
% xlim([0 100]);
% ylim([0 100]);
% axis square;
% 
% subplot(1,3,2)
% 
% surf(demo_U_sum);
% 
% shading interp
% xlim([0 100]);
% ylim([0 100]);
% axis square;

% 
% %% scale
% %% scale
% ix=1:2:199;
% 
% demo_X = X(ix,ix);
% demo_Y = Y(ix,ix);
% demo_F_sum_X = F_sum_X(ix,ix); 
% demo_F_sum_Y = F_sum_Y(ix,ix);
% demo_U_sum = U_sum(ix,ix);
% 
% hold on
% quiver(X,Y,F_sum_X,F_sum_Y);
% plot(qGoal(1),qGoal(2),'ro');
% plot(obstacle(1),obstacle(2),'gx');
% plot(qStart(1),qStart(2),'rx');
% plot(x,y,'rx');
% xlim([0 100]);
% ylim([0 100]);
% axis square;
% 





