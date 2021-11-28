clear
close all
clc

%% initialization

% goal set up
goal1 = [20, 20 ];
goal2 = [ goal1(1)+50* cos(pi/4),goal1(2)+50*sin(pi/4)];

% noise
V_SIGMA_SQR = 1;
SENSOR1_SIGMA_SQR = 6;
SENSOR2_SIGMA_SQR = 4;
dt = 0.3;
Vref = 5;
MAX_STERRING = pi/4;

% filter
F = eye(2);
H = eye(2); 
B = eye(2)*dt;
u = [0;0];
Q = eye(2)*V_SIGMA_SQR;
theta=pi/4;
Vx = Vref*cos(theta);
Vy = Vref*sin(theta);
X_true=[  goal1(1);

          goal1(2);
        ];  

      

X_est_sensor1(:,1)=X_true + [normrnd(0,sqrt(SENSOR1_SIGMA_SQR));
                normrnd(0,sqrt(SENSOR1_SIGMA_SQR))];
X_est_sensor2(:,1)=X_true + [normrnd(0,sqrt(SENSOR2_SIGMA_SQR));
                normrnd(0,sqrt(SENSOR2_SIGMA_SQR))];
X_true_list(:,1) = X_true;
X_est_list(:,1) = (X_est_sensor1(:,1) + X_est_sensor2(:,1))/2;     
         
%% update

Kp = 0.2;
Ki = 0.002;
Kd = 0.01;
output = 0;
previous_error = 0;
integral =0;
i = 1;

runningVel = 0;
% theta = randomNum(0,2*pi);

P_est_sensor1 = zeros(2,2);
P_est_sensor2 = zeros(2,2);

v_list(1) = 0;
dist_list = [];
Vx_list(1) = 0;
vy_list(1) = 0;
while 1
    
    
    %% PID fro Vel
    error = Vref - runningVel;
    integral = integral + error*dt;
    derivative = (error - previous_error)/dt;
    output =  Kp*error + Ki*integral + Kd*derivative;
    previous_error = error;
    runningVel = runningVel + output;% -0.01*runningVel;
    Vx = runningVel*cos(theta);
    Vy = runningVel*sin(theta);
    u = [Vx;Vy];
    
    Vx_list(i+1) = Vx;
    vy_list(i+1) = Vy;
    
    v_list(i+1)= runningVel;
%     X_true_list(:,i+1)=F*X_true_list(:,i) + B*(u + [normrnd(0,sqrt(V_SIGMA_SQR));  normrnd(0,sqrt(V_SIGMA_SQR))]);
% sensor1_true = X_true_list(:,i+1)+[normrnd(0,sqrt(SENSOR1_SIGMA_SQR));  normrnd(0,sqrt(SENSOR1_SIGMA_SQR))];
%     sensor2_true = X_true_list(:,i+1)+[normrnd(0,sqrt(SENSOR2_SIGMA_SQR));  normrnd(0,sqrt(SENSOR2_SIGMA_SQR))];

    tmp_x_true = F*X_true_list(:,i) + B*(u + [normrnd(0,sqrt(V_SIGMA_SQR));normrnd(0,sqrt(V_SIGMA_SQR))]);
    sensor1_true = tmp_x_true+[normrnd(0,sqrt(SENSOR1_SIGMA_SQR));normrnd(0,sqrt(SENSOR1_SIGMA_SQR))];
    sensor2_true = tmp_x_true+[normrnd(0,sqrt(SENSOR2_SIGMA_SQR));normrnd(0,sqrt(SENSOR2_SIGMA_SQR))];
    
    [tmp_x_est_sensor1,P_est_sensor1] =update_sensor(X_est_list(:,i),sensor1_true,P_est_sensor1,F,B,u,Q,H,eye(2)*SENSOR1_SIGMA_SQR);
    [tmp_x_est_sensor2,P_est_sensor2] =update_sensor(X_est_list(:,i),sensor2_true,P_est_sensor2,F,B,u,Q,H,eye(2)*SENSOR2_SIGMA_SQR);
%     [X_est_sensor1(:,i+1),P_est_sensor1]=update_sensor(X_est_list(:,i),sensor1_true,P_est_sensor1,F,B,u,Q,H,eye(2)*SENSOR1_SIGMA_SQR);
%     [X_est_sensor2(:,i+1),P_est_sensor2]=update_sensor(X_est_list(:,i),sensor2_true,P_est_sensor2,F,B,u,Q,H,eye(2)*SENSOR2_SIGMA_SQR);
    %avg sensor
    tmp_avg_est = (tmp_x_est_sensor1 + tmp_x_est_sensor2)/2;
%     X_est_list(:,i+1) = (X_est_sensor1(:,i+1) +X_est_sensor2(:,i+1))/2;  
    
    
    %% get theta 
%     thetaD = atan2(   (goal2(2) -tmp_avg_est(2)),(goal2(1) -tmp_avg_est(1)));
%     theta_diff=atan2(sin(thetaD-theta),cos(thetaD-theta  ) ) ;
%     runningTheta =Kp *theta_diff;
%     if runningTheta > MAX_STERRING
%         runningTheta = MAX_STERRING;
%     elseif runningTheta < -MAX_STERRING
%         runningTheta = -MAX_STERRING;
%     end
     d = sqrt( (goal2(1) -tmp_avg_est(1))^2 + (goal2(2) -tmp_avg_est(2))^2 );
     dist_list(i) = d;
%     d = sqrt( (goal2(1) -X_true_list(1,i))^2 + (goal2(2) -X_true_list(2,i))^2 );
    if d <= 2.5
        break
    end
    %% Update x,y, theta
%     theta = theta + runningTheta * dt;
    X_est_list(:,i+1) = tmp_avg_est;
    X_true_list(:,i+1) = tmp_x_true;
    X_est_sensor1(:,i+1) = tmp_x_est_sensor1;
    X_est_sensor2(:,i+1) = tmp_x_est_sensor2;
    
     
%     subplot(1,3,2)
    
    
    i = i + 1;
%     pause(0.01)
end

%% plot


% figure 
% hold on
% grid on
% scatter(goal1(1),goal1(2));
% scatter(goal2(1),goal2(2));
% xlim([0 100]);
% ylim([0 100]);
% axis square;

  figure
  subplot(1,3,1)
    hold on
    grid on
    scatter(goal1(1),goal1(2),'k');
    scatter(goal2(1),goal2(2),'r');

    
    plot(X_est_list(1,:), X_est_list(2,:) ,'r-');
%      plot(X_true_list(1,:), X_true_list(2,:) ,'b--');
    
%      scatter(X_est_sensor1(1,:),X_est_sensor1(2,:),'g.');
%      scatter(X_est_sensor2(1,:),X_est_sensor2(2,:),'m.');
    
    title("estimated robot position");
    legend("Start","End","Est","Sensor1","Sensor2");
     %legend("Start","End","X Est","X Measure","Est Sensor1","Est Sensor2"); 
    ylabel("y - 100m");
    xlabel("x -100m");
    xlim([0 100]);
    ylim([0 100]);
    axis square;
    hold off
    
    subplot(1,3,2)
    
    title("Velocity")
    hold on
    grid on
    plot(v_list);

    ylabel("V - m/s");
    xlabel("timestamps - dt=0.3");
    
    xlim([0 30]);
    ylim([0 7]);
    axis square;
    hold off
    
    subplot(1,3,3)
    hold on
    grid on
    title("distance to the goal")
    ylabel("Dist - m");
    xlabel("timestamps - dt=0.3");
    plot(dist_list);
    hold off;
    
    figure
    
     hold on
    grid on
    scatter(goal1(1),goal1(2),'k');
    scatter(goal2(1),goal2(2),'r');

    
     plot(X_est_list(1,:), X_est_list(2,:) ,'k-');
     
     plot(X_est_sensor1(1,:),X_est_sensor1(2,:),'g-');
     plot(X_est_sensor2(1,:),X_est_sensor2(2,:),'c-');
      scatter(X_est_sensor1(1,:),X_est_sensor1(2,:),'g.');
      scatter(X_est_sensor2(1,:),X_est_sensor2(2,:),'c.');
    
    title("sensor measurement together with the estimate");
    %legend("Start","End","Est","Sensor1","Sensor2");
      legend("Start","End","X Est","Sensor 1 Measure","Sensor 1 Measure","",""); 
    ylabel("y - 100m");
    xlabel("x -100m");
    xlim([0 100]);
    ylim([0 100]);
    axis square;
    hold off
    
    hold off
    
  
    
