w_hat=[0.667 0.667 0.333]'; % Rotation unit axis
q=[1 1 0.5]'; % Position vector
h=1; % Screw pitch
theta=deg2rad(250); % Rotation angle in deg, immediately converted to rad

S_s=[w_hat; cross(-w_hat,q)+w_hat*h]; % Screw axis
% Skew-symmetric representation of rotation unit axis
w_skew=[0 -w_hat(3) w_hat(2); w_hat(3) 0 -w_hat(1); -w_hat(2) w_hat(1) 0];
mat_log=[w_skew*theta S_s(4:6)*theta; 0 0 0 0]; % Rotation matrix logarithm
mat_exp=expm(mat_log) % Final HTM
