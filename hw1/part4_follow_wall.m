clear
close all
clc
%%
CLICK_ON_PLOT=1;
%% get user input
hold on
xlim([0 200])
ylim([0 200])
axis square;


[a b c] = get_user_click(CLICK_ON_PLOT);

x = 0:200;
y = (a*x - c)/b;
plot(x,y,"r-")

disp("test")
