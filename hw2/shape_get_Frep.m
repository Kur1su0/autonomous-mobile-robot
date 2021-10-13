function [Urep] = shape_get_Frep(X,Y,obstacle,eta,rho_zero)
%SHAPE_GET_UREP Summary of this function goes here
%   Detailed explanation goes here

Urep = zeros(size(X));
q = zeros(size(X));
bot=50;
up=70;
left=30;
right=50;
%(30,70) p1
%(50,70) p2
%(30,50) p3
%(50,50) p4

%% 8 dirs
%    ul|   u  | ur
%   ---xp1----x-p2--
%      |      |r
%   l  | mid  |
%   p3-x------x-p4--
% botL |bot   |bot right

%% assign rho_q for different pos.
[R, C] = size(X);
for i = 1:R
    for j = 1:C
        % upper case
        if  30<= X(i,j) && X(i,j)<=50 &&  Y(i,j) >= 70
            q(i,j) =  Y(i,j) - 70;
        elseif 30<= X(i,j) && X(i,j)<=50 && Y(i,j) <=50
        % bottom casse
            q(i,j) =  50 - Y(i,j);
            
        elseif 50 <= Y(i,j) && Y(i,j) <= 70 && X(i,j) <= 30
        % left case
            q(i,j) =  X(i,j) - 30;
            
        elseif  50 <= Y(i,j) && Y(i,j) <= 70 && X(i,j) >=50
        % right case
            q(i,j) =  50 - X(i,j);
            
        elseif X(i,j) < 30 && Y(i,j) > 70
            %upper left p1
            q(i,j) = sqrt( (X(i,j)- 30).^2 + (Y(i,j)- 70).^2 );
        elseif X(i,j) >50  && Y(i,j) > 70    
        % upper right  
            q(i,j) = sqrt( (X(i,j)- 50).^2 + (Y(i,j)- 70).^2 );
        elseif X(i,j) < 30 && Y(i,j) < 50
            %lower left
            q(i,j) = sqrt( (X(i,j)- 30).^2 + (Y(i,j)- 50).^2 );
            
        elseif X(i,j) > 50 && Y(i,j)<50
            %lower right
            q(i,j) = sqrt( (X(i,j)- 50).^2 + (Y(i,j)- 50).^2 );
        elseif X(i,j)>= 30 && X(i,j)<=50 && Y(i,j) >=50 && Y(i,j)<=70
            q(i,j) = 0;
        
        else
        end       
    end
    
end



% mask = q <= rho_zero;
% Urep = 1/2 .* eta .*((1.0./q  - 1.0./rho_zero).^2 ) .* mask;

for i=1:R
    for j = 1:C
        if X(i,j)>= 30 && X(i,j)<=50 && Y(i,j) >=50 && Y(i,j)<=70
            Urep(i,j) = max(max(Urep));
        elseif q(i,j) <= rho_zero
            Urep(i,j) = 1/2 * eta *((1.0./q(i,j)  - 1.0./rho_zero).^2 );
        end
    end
end




end

