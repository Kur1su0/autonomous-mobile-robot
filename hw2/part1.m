close all;
clear all;

xlim([0 100]);
ylim([0 100]);

fig=figure(1);
% 
% 
% set(fig,'position',[200 100 1500 800]);
qGoal = [80;20];
subplot(1,3,1);
hold on

%% cal attractive potential filed



[X,Y]=meshgrid(1:0.5:100,1:0.5:100);
epsilon = 1/60;
Uatt=1/2*epsilon*( (X-qGoal(1)).^2 + (Y-qGoal(2)).^2);
disp(size(Uatt))
[F_att_X,F_att_Y] = Fatt(X, Y, qGoal,epsilon);

%% scale
scale=1:5:200;
demo_X = X(scale,scale);
demo_Y = Y(scale,scale);
demo_F_att_X = F_att_X(scale,scale); 
demo_F_att_Y = F_att_Y(scale,scale);
demo_Uatt = Uatt(scale,scale) ;


epsilon = 1;
% Uatt =
% Urep = 
%% show contour
contour_num = 40;
contour(X,Y,Uatt,contour_num);
plot(qGoal(1),qGoal(2),'rx');
title("Contour - Uatt");

xlim([0 100]);
ylim([0 100]);
axis square;

%% show potiential field
subplot(1,3,2);
surf(X,Y,Uatt);
shading interp
title("Uatt");
xlim([0 100]);
ylim([0 100]);
axis square;


subplot(1,3,3);

% quiver(X,Y,F_att_X,F_att_Y);
hold on;
quiver(demo_X,demo_Y,demo_F_att_X,demo_F_att_Y);
plot(qGoal(1),qGoal(2),'rx');
title("Fatt")
disp(F_att_X)
xlim([0 100]);
ylim([0 100]);
axis square;

