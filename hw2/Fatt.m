function [retX,retY] = Fatt(X,Y,goal,epsilon)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
retX = -1 .* (X - goal(1)) .*epsilon;
retY =-1  .* (Y - goal(2)) .*epsilon;

end

