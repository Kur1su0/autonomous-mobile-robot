clear
close all
clc
%% prepare

MAXGOAL = 3;
%init val
Vref = 3;
MAX_STERRING = pi/4;

init_porp_bot = [100 100 randomNum(0,2*pi)];
%v(t+1)=v(t) + u(t) - 0.01v(t)
%gen 3 goals
goalArr = [];
%robot pos
x = [];
y = [];
theta=[];

vel= [];
x(1)= init_porp_bot(1);
y(1)= init_porp_bot(2);
vel(1) = 0;
init_theta= init_porp_bot(3);
theta(1) = init_porp_bot(3);

for i=1:MAXGOAL
    goalArr(i).x = randomNum(0,200);
    pause(0.01)
    goalArr(i).y = randomNum(0,200);
    pause(0.01)
    disp(goalArr(i));
end


initRobot = recBot(init_porp_bot(1),init_porp_bot(2),init_porp_bot(3));

fig=figure(1);
set(fig,'position',[400 100 1000 500]);
f1=subplot(1,2,1);

xlim([0 200])
ylim([0 200])
axis square;



f2=subplot(1,2,2);
grid on;
axis([0 1500 0 5])
ylabel("Velocity(m/s)")
xlabel("time(0.1s)")
% axis square;

subplot(1,2,1);
hold on
i = 1;
THRES = 1;
runningTheta = 0;
runningVel = 0;



Kp=0.35;
Ki=0.001;
Kd=0.003;
dt = 0.1;
output = 0;

for state=1:3
    output = 0;
    previous_error = 0;
    integral =0;

    while 1
        d = sqrt (  (goalArr(state).x-x(i))^2 + (goalArr(state).y-y(i))^2 );
        disp(state)
        %% PID fro Vel
        
        error = Vref - runningVel;
        integral = integral + error*dt;
        derivative = (error - previous_error)/dt;
        output =  Kp*error + Ki*integral + Kd*derivative;
        previous_error = error;
        runningVel = runningVel + output -0.01*runningVel;
        
        
        %% get theta
        thetaD = atan2((goalArr(state).y - y(i)),(goalArr(state).x-x(i))  );
        theta_diff=atan2(sin(thetaD-theta(i)),cos(thetaD-theta(i)  ) ) ;
%         theta_diff=thetaD-theta(i);
%         if theta_diff>pi
%             theta_diff=theta_diff-2*pi;
%             disp("LARGE")
%         elseif theta_diff<-pi
%             theta_diff=theta_diff+2*pi;
%             disp("SMALL")
%         end
    
        runningTheta =Kp *theta_diff;
        if runningTheta > MAX_STERRING
            runningTheta = MAX_STERRING;
        elseif runningTheta < -MAX_STERRING
            runningTheta = -MAX_STERRING;
        end
        

        
        
        %% Update x,y, theta
        x(i+1) = x(i) + runningVel * cos(theta(i)) * dt;
        y(i+1) = y(i) + runningVel * sin(theta(i)) * dt;
        theta(i+1) = theta(i) + runningTheta * dt;
        
        
                
        
        
        
        
        
        curRobot = recBot(x(i),y(i),theta(i));
        %% plot
        subplot(1,2,1)
        %plot cur bot
        plot(curRobot(1,1),curRobot(1,2),'r.',curRobot(1:2,1),curRobot(1:2,2),'r',curRobot(3:end,1),curRobot(3:end,2),'-',x,y,'r-');
        text(x(i)+10, y(i)+10, sprintf('(%.2f,%.2f),v=%.2fm/s', x(i),y(i),runningVel),'FontSize',8);
        hold on
        
        grid on;
        ylabel("x (m)")
        xlabel("y (m)")
        %plot prev bot
        plot(initRobot(1,1),initRobot(1,2),'r.',initRobot(1:2,1),initRobot(1:2,2),'r',initRobot(3:end,1),initRobot(3:end,2),'--');
        text(init_porp_bot(1)+10, init_porp_bot(2)+10, sprintf('(%.2f,%.2f)', init_porp_bot(1),init_porp_bot(2)),'FontSize',8);
        
        %plot 3 goals
        for each=1:MAXGOAL
            GoalX = goalArr(each).x;
            GoalY = goalArr(each).y;
            plot(GoalX,GoalY,'x');
            text(GoalX+10,GoalY,sprintf("G%d:(%.2f,%.2f)",each,GoalX,GoalY),'FontSize',8);
        end
        

        hold off
        %%
        xlim([0 200])
        ylim([0 200])
        axis square;
        
        subplot(1,2,2)
        vel(i+1) = runningVel;
        hold on
        plot(vel,'r-');
        hold off
        
        
        
        
        if d < THRES
            disp("break");
            i = i+1;
            break
        end
        i = i+1;
        pause(0.01);
        
        
        
        
    end
    
   
end

%plot bot
% i=1;
% initRobot = recBot(x(1),y(1),theta);
% plot(initRobot(1,1),initRobot(1,2),'r.',initRobot(1:2,1),initRobot(1:2,2),'r-',initRobot(3:end,1),initRobot(3:end,2),'-',x,y,'-');
% text(x(i)+10, y(i)+10, sprintf('(%.3f,%.3f, vel:%.3fm/s)', initRobot(i),initRobot(i),0));








