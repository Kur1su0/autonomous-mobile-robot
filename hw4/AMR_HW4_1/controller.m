function [ u ] = pd_controller(~, s, s_des, params)
%PD_CONTROLLER  PD controller for the height
%
%   s: 2x1 vector containing the current state [z; v_z]
%   s_des: 2x1 vector containing desired state [z; v_z]
%   params: robot parameters

u = 0;


% FILL IN YOUR CODE HERE
kp = 75;
kv = 15;

pos = s(1);
vel = s(2);
pos_des = s_des(1);
vel_des = s_des(2);

e = pos_des - pos;
e_dot = vel_des - vel;

u=params.mass*( kp*e + kv*e_dot + params.gravity);

end

