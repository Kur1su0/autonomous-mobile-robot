function [Fx,Fy] = get_Frep(X,Y,obstacle,eta,rho_zero)
%GET_FREP Summary of this function goes here
%   Detailed explanation goes here

%dist
q = sqrt( (X - obstacle(1)) .^2 + (Y - obstacle(2)) .^2  ) +1e-3;
q = q./20 +1;

mask = q <= rho_zero;


% delta p of q
Fx_diff = (X - obstacle(1)) ./ sqrt( (X-obstacle(1) ) .^2 + (Y-obstacle(2) ) .^2 );
Fy_diff = (Y - obstacle(2)) ./ sqrt( (X-obstacle(1) ) .^2 + (Y-obstacle(2) ) .^2);

Fx = eta .* (1.0./q - 1.0./rho_zero) .* (1.0./(q.^2)) .* Fx_diff .* mask;
Fy = eta .* (1.0./q - 1.0./rho_zero) .* (1.0./(q.^2)) .* Fy_diff .* mask;

end

