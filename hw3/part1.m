close all;
clear all;



%Sensor
sensor1_sigma = 6;
sensor2_sigma = 4;
sensor = [
    1 0 0 0; 0 0 1 0; % 1
    1 0 0 0; 0 0 1 0; % 2
    ];

goal1 = [30,30 ];
goal2 = [ goal1(1)+50* sin(pi/4),goal1(2)+50*cos(pi/4)];


figure 
hold on
grid on
scatter(goal1(1),goal1(2));
scatter(goal2(1),goal2(2));
xlim([0 100]);
ylim([0 100]);
axis square;

