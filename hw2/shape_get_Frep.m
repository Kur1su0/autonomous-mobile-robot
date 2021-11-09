function [Fx,Fy] = shape_get_Frep(X,Y,obstacle,eta,rho_zero)
%SHAPE_GET_UREP Summary of this function goes here
%   Detailed explanation goes here


Fx = zeros(size(X));
Fy =  zeros(size(X));

q = zeros(size(X));

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
b_pos = zeros(R,C,2);
for i = 1:R
    for j = 1:C
        % upper case
        if  30<= X(i,j) && X(i,j)<=50 &&  Y(i,j) > 70
            q(i,j) =  Y(i,j) - 70; 
            b_pos(i,j,1) = X(i,j); b_pos(i,j,2) = 70; 

        elseif 30<= X(i,j) && X(i,j)<=50 && Y(i,j) <50
        % bottom casse
            q(i,j) =  50 - Y(i,j);
            b_pos(i,j,1) = X(i,j); b_pos(i,j,2) = 50; 

            
        elseif 50 <= Y(i,j) && Y(i,j) <= 70 && X(i,j) < 30
        % left case
            q(i,j) =  30 - X(i,j) ;
            b_pos(i,j,1) = 30; b_pos(i,j,2) = Y(i,j); 
            
        elseif  50 <= Y(i,j) && Y(i,j) <= 70 && X(i,j) >50
        % right case
            q(i,j) =  X(i,j) - 50;
            b_pos(i,j,1) = 50; b_pos(i,j,2) = Y(i,j); 
            
        elseif X(i,j) < 30 && Y(i,j) > 70
            %upper left p1
            q(i,j) = sqrt( (X(i,j)- 30).^2 + (Y(i,j)- 70).^2 );
             b_pos(i,j,1) = 30; b_pos(i,j,2) = 70;
            
        elseif X(i,j) >50  && Y(i,j) > 70    
        % upper right  
            q(i,j) = sqrt( (X(i,j)- 50).^2 + (Y(i,j)- 70).^2 );
            b_pos(i,j,1) = 50; b_pos(i,j,2) = 70;
            
        elseif X(i,j) < 30 && Y(i,j) < 50
            %lower left
            q(i,j) = sqrt( (X(i,j)- 30).^2 + (Y(i,j)- 50).^2 );
            b_pos(i,j,1) = 30; b_pos(i,j,2) = 50;
            
        elseif X(i,j) > 50 && Y(i,j)<50
            %lower right
            q(i,j) = sqrt( (X(i,j)- 50).^2 + (Y(i,j)- 50).^2 );
            b_pos(i,j,1) = 50; b_pos(i,j,2) = 50;
            
        elseif X(i,j)>= 30 && X(i,j)<=50 && Y(i,j) >=50 && Y(i,j)<=70
            q(i,j) = 0;
        
        else
        end  
     
    end
    
end


% mask = q <= rho_zero;
% Urep = 1/2 .* eta .*((1.0./q  - 1.0./rho_zero).^2 ) .* mask;
q = q./20 + 1;
for i=1:R
    for j = 1:C
        
        if X(i,j)>= 30 && X(i,j)<=50 && Y(i,j) >=50 && Y(i,j)<=70
            Fx(i,j) = 0;
            Fy(i,j) = 0;
        elseif q(i,j) <= rho_zero
            gradFx = (X(i,j) - b_pos(i,j,1))/ (sqrt(  (X(i,j)-b_pos(i,j,1))^2 + (Y(i,j)-b_pos(i,j,2))^2) );
            gradFy = (Y(i,j) - b_pos(i,j,2)) / (sqrt( (X(i,j)-b_pos(i,j,1))^2 + (Y(i,j)-b_pos(i,j,2))^2) );
           

            
            Fx(i,j) = eta * (1.0/q(i,j) - 1.0/rho_zero  ) * 1.0/(q(i,j).^2) * gradFx; 
            Fy(i,j) = eta * (1.0/q(i,j) - 1.0/rho_zero  ) * 1.0/(q(i,j).^2) * gradFy; 
            
        else
            Fx(i,j) = 0;
            Fy(i,j) = 0;
        end
    end
end




end

