clear
close all
clc
%%
% CLICK_ON_PLOT=1;
%% gen plot
fig=figure(1);
set(fig,'position',[400 100 1000 500]);
f1=subplot(1,2,1);
grid on;
axis ([0 200 0 200])
xlim([0 200])
ylim([0 200])
axis square;

f2=subplot(1,2,2);
grid on;
title("Dist - Time");
ylabel("dist m")
xlabel("time(0.1s)")
axis square;


hold on %XXX
subplot(1,2,1);
xlim([0 200])
ylim([0 200])
axis square;

%% get user input
% [a b c] = get_user_click(CLICK_ON_PLOT);
% 
% line_x = 0:200;
% line_y = (a*line_x - c)/b;
% % plot(line_x,line_y,"r-");
% % hold off
% disp(sprintf("a=%.3f, b=%.3f, c=%.3f",a,b,c));


%%
x = [];
y = [];
d_list = [];

theta = [];
dt = 0.1;
init_bot_pos = [100 100 randomNum(0,2*pi)];
% init_porp_bot = [100 100 randomNum(0,2*pi)];
initRobot = recBot(init_bot_pos(1),init_bot_pos(2), init_bot_pos(3) );
x(1)= init_bot_pos(1);
y(1)= init_bot_pos(2);
theta(1)=init_bot_pos(3);


MAX_STERRING = pi/4;
MAX_VEL = 5;
MAX_DIST=10;
THRES = 1;
Kt=0.015;
Kh=0.5;

i = 1;
runningTheta = 0;
runningVel = MAX_VEL;

k = 0;
m = 0;
% if 1 -> accept usr input
% else -> random
CLICK_ON_PLOT=1;
integral = 0;
error = 0;
previous_error = 0;
output = 0;

while 1

    if i == 1
        %% get user input
        
%         a = 25;
%         b = -23;
%         c = 840;
        
        plot(initRobot(1,1),initRobot(1,2),'r.',initRobot(1:2,1),initRobot(1:2,2),'r',initRobot(3:end,1),initRobot(3:end,2),'-');
        text(init_bot_pos(1)+10, init_bot_pos(2)+10, sprintf('(%.2f,%.2f)', init_bot_pos(1),init_bot_pos(2)),'FontSize',8);
        axis ([0 200 0 200])
        xlim([0 200])
        ylim([0 200])
        axis square;
        [a b c] = get_user_click(CLICK_ON_PLOT);

        line_x = 0:200;
        line_y = (-a*line_x - c)/(b);
        
        
    end

    
    d = (a*x(i) + b*y(i) + c) / sqrt(a^2 +b^2);
    ori_d = d;
    disp(d);
    if d<=0
        d = d + MAX_DIST;
    else
        d = d - MAX_DIST;
    end
    
    %% update theta
    alpha_t = -1 * Kt * (d );

    theta_d = atan2(-1*a,b);
    alpha_h = Kh * atan2(sin(theta_d - theta(i)),cos(theta_d - theta(i)));

%     alpha_h = Kh * atan2(sin(theta_d - theta(i)),cos(theta_d - theta(i)));
    runningTheta = alpha_t + alpha_h;
    
    if runningTheta > MAX_STERRING
        runningTheta = MAX_STERRING;
    elseif runningTheta < -MAX_STERRING
        runningTheta = - MAX_STERRING;
    end
    
    %% update x,y, theta
    x(i+1) = x(i) + runningVel * cos(theta(i)) * dt;
    y(i+1) = y(i) + runningVel * sin(theta(i)) * dt;
    theta(i+1) = theta(i) + runningTheta * dt;
    %% plot
    % plot position
    curRobot = recBot(x(i),y(i),theta(i));
    
    subplot(1,2,1)
    plot(curRobot(1,1),curRobot(1,2),'r.',curRobot(1:2,1),curRobot(1:2,2),'r',curRobot(3:end,1),curRobot(3:end,2),'-',x,y,'r-');
    text(x(i)+10, y(i)+10, sprintf('(%.2f,%.2f),v=%.2fm/s', x(i),y(i),runningVel),'FontSize',8);
    
    hold on
    % init pos
    plot(initRobot(1,1),initRobot(1,2),'r.',initRobot(1:2,1),initRobot(1:2,2),'r',initRobot(3:end,1),initRobot(3:end,2),'--');
    text(init_bot_pos(1)+10, init_bot_pos(2)+10, sprintf('(%.2f,%.2f)', init_bot_pos(1),init_bot_pos(2)),'FontSize',8);
    plot(line_x,line_y,"b-");
    
    title("Position");
    
    ylabel("Y (m)")
    xlabel("X (m)")
    axis square;
    
    
%     text (130, line_y(130)+20,sprintf('%.2fX+(%.2fY)+(%.2f) = 0',a,b,c),'FontSize',8);
   
    
    hold off
    axis ([0 200 0 200])
    xlim([0 200])
    ylim([0 200])
    
    axis square;

    % plot distance
    d_list(i) = abs(ori_d);
    subplot(1,2,2);
    hold on
    plot(d_list,'r-');
%     axis ([0 300 0 150])
    hold off
    
    if x(i)<0 || y(i)<0 || x(i) > 200 || y(i) > 200 
       break;
    end
    i  = i + 1;
    pause(0.01);
end

subplot(1,2,1)
legend("","","Cur Pos","","","Trajectory","Init Pos","Wall");









