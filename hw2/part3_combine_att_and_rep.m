close all;
clear all;


qGoal = [80;20];


meanX = mean([30,50,50,30]);
meanY = mean([50,50,70,70]);
obstacle = [meanX, meanY];

%% att
[X,Y]=meshgrid(1:0.5:100.,1:0.5:100);
epsilon = 1;
Uatt=1/2 *epsilon.*( (X-qGoal(1)).^2 + (Y-qGoal(2)).^2);
[F_att_X,F_att_Y] = Fatt(X, Y, qGoal,epsilon);

%% rep
eta = 80;
rho_0 = 20;
Urep = get_Urep(obstacle,X, Y, eta,rho_0);
[Frep_X,Frep_Y] = get_Frep(X,Y,obstacle,eta,rho_0);


U_sum = Uatt + Urep;
F_sum_X = F_att_X + Frep_X;
F_sum_Y = F_att_Y + Frep_Y;

%% scale
scale=1:5:199;

demo_X = X(scale,scale);
demo_Y = Y(scale,scale);
demo_F_sum_X = F_sum_X(scale,scale); 
demo_F_sum_Y = F_sum_Y(scale,scale);
demo_U_sum = U_sum(scale,scale);


%% show contour
subplot(1,3,1)
contour_num = 40;
hold on;
contour(X,Y,U_sum,contour_num);
plot(qGoal(1),qGoal(2),'rx');
plot(obstacle(1),obstacle(2),'bx');
title("Contour - Combined field");
xlim([0 100]);
ylim([0 100]);
axis square;

subplot(1,3,2)

surf(X,Y,U_sum);

shading interp
title("U_s_u_m = U_r_e_p + U_a_t_t ");

xlim([0 100]);
ylim([0 100]);
axis square;


%% scale
subplot(1,3,3)
hold on
quiver(demo_X,demo_Y,demo_F_sum_X,demo_F_sum_Y);
title("F_s_u_m = U_r_e_p + U_a_t_t");
plot(qGoal(1),qGoal(2),'rx');
plot(obstacle(1),obstacle(2),'bx');
xlim([0 100]);
ylim([0 100]);
axis square;






