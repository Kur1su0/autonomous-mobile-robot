clear
close all
clc


%% Parameters

maxVel = 5;
maxSteer = pi/4;
% Workspace Size
xlim([0 200])
ylim([0 200])

% Init plot config.
fig=figure(1);
hold on
set(fig,'position',[100 100 800 400]);
f1=subplot(1,2,1);
xlim([0 200])
ylim([0 200])
axis square;
grid on;


f2=subplot(1,2,2);
axis([0 2000 0 5.5])
grid on;
grid on;
title("Velocity - Time")
ylabel("Velocity (m/s)")
xlabel("time (0.1s)")

%Init positions for the robot
p1.x =  randomNum(0,200);
p1.y = randomNum(0,200);
p1.theta = randomNum(0,2*pi);
%gen circle w/ r= 75 at 100,100
center = [100 100];
r = 75; %dd

%get transfotmed & rotated from part 1
initRobot = recBot(p1.x,p1.y,p1.theta);

dt = 0.1;

x = [];
y = [];
theta =[];
v = [];
x(1) = p1.x;
y(1) = p1.y;
theta(1) = p1.theta;
i = 1;
Kp = 0.5;
Ki = 0.003;
Kh = 1.7;
runningVel = 0;
runningTheta = 0;
integral = 0;


%% gen circle
angles = linspace(0, 2*pi,720*1.5);
Cx = r * cos(angles) + center(1); 
Cy = r * sin(angles) + center(2);
% disp(Cx)
LC = length(Cx);
where = int32(randomNum(1,LC));
while 1
%     disp(mod(i,LC));
    
    where = mod(where+1,length(Cx));
     
    if where == 0
        where = where +1;
    end
    % 8 prev dx,y
    e = sqrt ( (Cx(where)-x(i))^2 + (Cy(where)- y(i) )^2 ) - 8;
%     disp(e);

%     e = sqrt ( (center(1)-x(i))^2 + (center(2)-y(i) )^2 ) - (r - x(i))  ;
    integral = integral + e*dt;
    
    theta_d = atan2( (Cy(where)-y(i)), (Cx(where)-x(i)));
    theta_diff = atan2( sin(theta_d - theta(i)), cos(theta_d - theta(i)));
    runningVel = Kp * e + Ki* integral;
    if runningVel > maxVel
        runningVel = maxVel;
    elseif runningVel < -maxVel
        runningVel = -maxVel;
    end
    
    runningTheta =  Kh * theta_diff;
    if runningTheta > maxSteer
        runningTheta = maxSteer;
    elseif runningTheta < -maxSteer
        runningTheta = -maxSteer;
    end
    
    x(i+1) = x(i) + runningVel * cos(theta(i)) * dt;
    y(i+1) = y(i) + runningVel * sin(theta(i)) * dt;
    theta(i+1) = theta(i) + runningTheta * dt;
    
    
    %% plot
    % position
    curRobot = recBot(x(i),y(i),theta(i));
    subplot(1,2,1)
    
    plot(curRobot(1,1),curRobot(1,2),'r.',curRobot(1:2,1),curRobot(1:2,2),'-',curRobot(3:end,1),curRobot(3:end,2),'-',x,y,'r-');
    text(x(i)+10, y(i)+10, sprintf('(%.2f,%.2f),v=%.2fm/s', x(i),y(i),runningVel),'FontSize',8);
    
    hold on;
    grid on
    title("Posittion");
    xlabel("x (m)");
    ylabel("x (m)");
    plot(Cx(where),Cy(where),'gx');
    plot(Cx,Cy,'b-');
    plot(100,100,'bx')
    plot(initRobot(1,1),initRobot(1,2),'r.',initRobot(1:2,1),initRobot(1:2,2),'r',initRobot(3:end,1),initRobot(3:end,2),'--');
    text(p1.x+10, p1.y+10, sprintf('(%.2f,%.2f)', p1.x, p1.y),'FontSize',8);
    hold off;
    xlim([0 200])
    ylim([0 200])
    axis square;

    i = i + 1;
    
    % plot Vel
    subplot(1,2,2)
    hold on
    v(i) = runningVel;
    plot(v,'r-');
    
    hold off
    
    pause(0.01)

end




