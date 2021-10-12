close all;
clear all;

xlim([0 100]);
ylim([0 100]);

qGoal = [80;20];
subplot(1,3,1);
hold on

meanX = mean([30,50,50,30]);
meanY = mean([50,50,70,70]);
obstacle = [meanX, meanY];

%% att
[X,Y]=meshgrid(1:0.5:100,1:0.5:100);
Uatt=1/2*( (X-qGoal(1)).^2 + (Y-qGoal(2)).^2);
[F_att_X,F_att_Y] = Fatt(X, Y, qGoal);

Urep = get_Urep(X, Y,eta,rho_zero );

%% rep
eta = 3000;
rho_0 = 2000;
Urep = get_Urep(obstacle,X, Y, eta,rho_0);
[Frep_X,Frep_Y] = get_Frep(obstacle,X,Y,obstacle,eta,rho_0);


% %% scale
% ix=1:5:200;
% demo_X = X(ix,ix);
% demo_Y = Y(ix,ix);
% demo_F_att_X = F_att_X(ix,ix); 
% demo_F_att_Y = F_att_Y(ix,ix);
% demo_Uatt = Uatt(ix,ix) ;





