w=[3 2 1]; % Angular velocity vector
theta=norm(w); % Rotation amplitude
w_n=w/theta; % Axis of rotation

% Simplifying the notation
w1=w_n(1);
w2=w_n(2);
w3=w_n(3);
c=cos(theta);
s=sin(theta);

% Equation 3
R=[c+w1^2*(1-c) w1*w2*(1-c)-w3*s w1*w3*(1-c)+w2*s
   w1*w2*(1-c)+w3*s c+w2^2*(1-c) w2*w3*(1-c)-w1*s
   w1*w3*(1-c)-w2*s w2*w3*(1-c)+w1*s c+w3^2*(1-c)]