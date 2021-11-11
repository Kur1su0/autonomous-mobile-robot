clear;
close all;
clc;

ROTATION_RATE = 0.2; %rad/s
MOVING_RATE = 1;

LANDMARKS = [25 25 ;25 70 ;70 25;  70 70; 10 40 ; 80 60];
Robot_init= [50+(20*rand(1)-10), 50+(20*rand(1)-10), 2*pi*rand(1)];
% init random particles
N = 10;
range_100 = 0:100;
range_theta = 0:2*pi;
% r1 = unifrnd(a1,b1)
% particles = zeros(N,3);
particles(:,1,2) = unifrnd(0,100,N);


% figure
% grid on;
% hold on;
% xlim([0 100]);
% ylim([0 100]);
% axis square;
% 
% for i = 1 : length(LANDMARKS)
%     scatter(LANDMARKS(i,1),LANDMARKS(i,2),'r')
%     
% end
% scatter(Robot_init(1),Robot_init(2),'bx')


