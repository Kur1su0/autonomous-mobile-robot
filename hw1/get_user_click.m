function [a,b,c] = get_user_click(isClick)
if isClick==1
    [p1,p2] = ginput(2);
else
    p1=[randomNum(0,200) randomNum(0,200)];
    p2=[randomNum(0,200) randomNum(0,200)];
end

pt1.x = p1(1);
pt1.y = p2(1);

pt2.x = p1(2);
pt2.y = p2(2);

a = pt1.y-pt2.y;
b = pt2.x-pt1.x;
c = pt1.x * pt2.y - pt2.x * pt1.y;


end

