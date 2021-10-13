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
eta = 3000;
rho_0 = 20;
Urep = shape_get_Urep(X, Y, obstacle,eta,rho_0);
[Fx,Fy] = shape_get_Frep(X,Y,obstacle,eta,rho_0);

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
shading interp
xlim([0 100]);
ylim([0 100]);
axis square;


subplot(1,3,3);
scale=1:5:199;
demo_X = X(scale,scale);
demo_Y = Y(scale,scale);
demo_Fx = Fx(scale,scale); 
demo_Fy = Fy(scale,scale);
% quiver(X,Y,F_att_X,F_att_Y);
% 
hold on
% 
%[F_att_X,F_att_Y] = Fatt(X, Y, qGoal);
% 
quiver(demo_X,demo_Y,demo_Fx,demo_Fy);


plot(qGoal(1),qGoal(2),'rx');
plot(obstacle(1),obstacle(2),'bx');
xlim([0 100]);
ylim([0 100]);
axis square;

