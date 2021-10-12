function [Urep] = get_Urep(obstacle,X,Y,eta,rho_zero)
%GET_UREP Summary of this function goes here
%   Detailed explanation goes here
% cal U rep for obstcale.

% Urep =  (X - obstacle(1))

Urep = zeros(size(X));
[C , R ] = size(X);
for i = 1:C
    for j = 1:R
        q = sqrt( (X(i,j) - obstacle(1)).^2 + (Y(i,j) - obstacle(2)).^2) + 1;
%         q = q / 20+1;
        if q <= rho_zero
            Urep(i,j) = 1/2 * eta * (1.0/q - 1.0/rho_zero).^2;
        else
            Urep(i,j) = 0;
        end
 
    end
end

end

