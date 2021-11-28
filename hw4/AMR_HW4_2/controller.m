function [ u1, u2 ] = controller(~, state, des_state, params)
%CONTROLLER  Controller for the planar quadrotor
%
%   state: The current state of the robot with the following fields:
%   state.pos = [y; z], state.vel = [y_dot; z_dot], state.rot = [phi],
%   state.omega = [phi_dot]
%
%   des_state: The desired states are:
%   des_state.pos = [y; z], des_state.vel = [y_dot; z_dot], des_state.acc =
%   [y_ddot; z_ddot]
%
%   params: robot parameters

%   Using these current and desired states, you have to compute the desired
%   controls

u1 = 0;
u2 = 0;

% FILL IN YOUR CODE HERE
kp_z = 25;
kv_z = 20;

z_dot_dot = des_state.acc(2);
u1 = params.mass * (params.gravity + z_dot_dot + kv_z*(des_state.vel(2) - state.vel(2)) + kp_z*(des_state.pos(2) - state.pos(2))   );

kp_phi = 250;
kv_phi = 20;
Kp_y = 5;
Kv_y = 15;


phi_c= -1/params.gravity * (des_state.acc(1) + Kv_y*(des_state.vel(1) - state.vel(1)) + Kp_y*(des_state.pos(1) - state.pos(1)));
phi_c_dot=-1/params.gravity * (0 + Kp_y*(des_state.vel(1) - state.vel(1)));

delta_phicdot_phidot = phi_c_dot -state.omega;
delta_phic_phi = phi_c - state.rot;

% phi_c_dot = phi_c - state.rot;
% phi_c_dot_dot = phi_c_dot - state.omega;

u2= params.Ixx*(kv_phi*delta_phicdot_phidot +kp_phi*delta_phic_phi  );

end

