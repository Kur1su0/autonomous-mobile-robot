function [a,b,c] = get_user_click(isClick)
if isClick==1
    [x,y] = ginput(2);
else
    p1=[randomNum(0,200) randomNum(0,200)];
    p2=[randomNum(0,200) randomNum(0,200)];
end

pt1.x = x(1);
pt1.y = y(1);

pt2.x = x(2);
pt2.y = y(2);

a = pt1.y-pt2.y;
b = pt2.x-pt1.x;
c = pt1.x * pt2.y - pt2.x * pt1.y;


end

