function [finalX,finalY] = moveRotate(curPos,movement)
%HOMOTRANSFOR Summary of this function goes here
%   Detailed explanation goes here
curX = curPos(1);
curY = curPos(2);

movX= movement(1);
movY = movement(2);
theta = movement(3);

rotMat = [
          cos(theta) -sin(theta) movX; 
          sin(theta) cos(theta)  movY;
          0          0           1
          ];

res = rotMat * [curX; curY; 1];

finalX = res(1)
finalY = res(2)
%disp(res)
end

