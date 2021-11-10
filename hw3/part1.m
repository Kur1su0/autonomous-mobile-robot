close all;
clear all;
%Sensor
sensor1_sigma = 6;
sensor2_sigma = 4;
sensor = [
    1 0 0 0; 0 0 1 0; % 1
    1 0 0 0; 0 0 1 0; % 2
    ];

goal1 = [30, 30 ];
goal2 = [ goal1(1)+50* sin(pi/4),goal1(2)+50*cos(pi/4)];

v_sigma = 1;
sensor1_sigma = 4;
sensor2_sigma = 6;


dt = 0.1;
Kv = 0.3;
Kp = 0.1;
Vref = 5;

%% initialization
diff=atan2((goal2(2)-goal1(2)),((goal2(1)-goal1(1))));
Vx = Vref*cos(diff);
Vy = Vref*sin(diff);
X_true=[  goal1(1); 
          0;
          goal1(2);
          0];  
X_est=X_true + [normrnd(0,v_sigma);
                normrnd(0,v_sigma);
                normrnd(0,v_sigma);
                normrnd(0,v_sigma)]; 


P_est=zeros(4,4);
R_sensor1=[sensor1_sigma*eye(2)]; %eye: I matrix
R_sensor2=[sensor2_sigma*eye(2)];
R_sensor = [R_sensor1;R_sensor2];
A=  [1, dt,  0,  0;
     0,  1, 0,  0;
     0,  0,  1,  dt;
     0,  0,  0,  1];
v_sigma=1;
B=[1/2*dt^2,   0;
        dt,    0 ;
        0,     1/2*dt^2 ;
        0,     dt];
%Z
%H
%R
%S
%% update


%% plot


figure 
hold on
grid on
scatter(goal1(1),goal1(2));
scatter(goal2(1),goal2(2));
xlim([0 100]);
ylim([0 100]);
axis square;

