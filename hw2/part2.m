close all;
clear all;


qGoal = [80;20];


% fig=figure(1);
% set(fig,'position',[200 100 1500 800]);
% subplot(1,3,1);
% hold on
meanX = mean([30,50,50,30]);
meanY = mean([50,50,70,70]);
obstacle = [meanX, meanY];

%% cal attractive potential filed
%u
[X,Y]=meshgrid(1:0.5:100,1:0.5:100);
eta = 10;
rho_0 = 100;
Urep = get_Urep(obstacle,X, Y, eta,rho_0);
[Fx,Fy] = get_Frep(X,Y,obstacle,3000,rho_0);

% 
subplot(1,3,1);
hold on;
contour_num = 40;
contour(X,Y,Urep,contour_num);
plot(qGoal(1),qGoal(2),'rx');

xlim([0 100]);
ylim([0 100]);
axis square;

subplot(1,3,2);
surf(X,Y,Urep);
xlim([0 100]);
ylim([0 100]);
axis square;


subplot(1,3,3);
ix=1:1:199;
demo_X = X(ix,ix);
demo_Y = Y(ix,ix);
demo_Fx = Fx(ix,ix); 
demo_Fy = Fy(ix,ix);
% quiver(X,Y,F_att_X,F_att_Y);
% 
hold on
% 
% [F_att_X,F_att_Y] = Fatt(X, Y, qGoal);
% 
% quiver(X,Y,F_att_X,F_att_Y);
quiver(X,Y,Fx,Fy);
plot(qGoal(1),qGoal(2),'rx');
plot(obstacle(1),obstacle(2),'bx');
xlim([0 100]);
ylim([0 100]);
axis square;

