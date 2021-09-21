
clear
close all
clc

a = -1;
b = 1;
c = 0;
line_x = 0:0.02:200;
line_y = (a*line_x + c)/(-b);

plot(line_x,line_y);