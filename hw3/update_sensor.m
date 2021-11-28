function [X_est_sensor,P_est_sensor] = update_sensor(X_est,sensor_true,P_est,F,B,u,Q,H,R)
%UPDATE_ALL Summary of this function goes here
%   Detailed explanation goes here


pred_X = F * X_est + B*u;
P_pred = F*P_est*F' + Q;


y = sensor_true - H*pred_X;
S = H*P_pred*H'+R;
K = P_pred*H'/S;
X_est_sensor = pred_X + K*y;
I = eye(2);
P_est_sensor = (I-K*H)*P_pred;


end


