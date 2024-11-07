% drawMatrixExp Takes a normalised screw axis S in {s}, angle of rotation
% around screw axis theta in degrees, HTM Tsb of {b} in {s}, then
% calculates HTM Tsc - {b} after it has rotated and translated around S,
% and plots all HTMs

function [Tsc] = drawMatrixExp(S,theta,Tsb)

theta=deg2rad(theta); % Rotation angle in deg, immediately converted to rad
w_hat=S(1:3); % Rotation unit axis
% Skew-symmetric representation of rotation unit axis
w_skew=[0 -w_hat(3) w_hat(2); w_hat(3) 0 -w_hat(1); -w_hat(2) w_hat(1) 0];

mat_log=[w_skew*theta S(4:6)*theta; 0 0 0 0]; % Rotation matrix logarithm
Tbc=expm(mat_log); % HTM of {c} in {b}
Tsc=Tsb*Tbc; % Final HTM

% Plotting all HTMs
trplot(eye(4), 'color', 'b', 'frame', '{s}')
hold on
trplot(Tsb, 'color', 'g', 'frame', '{b}')
trplot(Tsc, 'color', 'r', 'frame', '{c}')
end