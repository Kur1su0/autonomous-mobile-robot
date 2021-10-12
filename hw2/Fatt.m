function [retX,retY] = Fatt(X,Y,goal)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
retX = -1 .* (X - goal(1));
retY =-1  .* (Y - goal(2));

end

