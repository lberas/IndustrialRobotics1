theta=[0 0 0 0 0 0]; % Initial angle/position vector
theta_dot=[0.2 0.05 0.2 0 0.01 0]'; % Joint velocity vector
L=[0.3 0.2 0.1 0.1]; % Link lengths

% Joint position in initial configuration
q=[[0 0 0]' [L(1) 0 0]' [L(2) 0 0]' [L(3) 0 0]' [L(4) 0 0]'];

positions=zeros(3,21);
angles=zeros(4,21);

for i=1:21

    % Joint HTMs
    Ts1=[rotz(theta(1)) q(:,1); 0 0 0 1];
    T12=[rotz(theta(2)) q(:,2); 0 0 0 1];
    Ts2=Ts1*T12;
    T23=[rotz(theta(3)) q(:,3); 0 0 0 1];
    Ts3=Ts2*T23;
    T34=[eye(3) q(:,4); 0 0 0 1];
    Ts4=Ts3*T34;
    T45=[eye(3) [theta(5) 0 0]'; 0 0 0 1];
    Ts5=Ts4*T45;
    T5e=[rotz(90,'deg') q(:,5); 0 0 0 1];
    Tse=Ts5*T5e;

    % Recording end-effector positions 
    positions(:,i)=Tse(1:3,4);
    angles(:,i)=theta([1 2 3 5]);

    theta=theta+theta_dot;
end

figure(1)
plot(positions(1,:),positions(2,:),'bo')
title('2D plot of end-effector position in meters')
xlabel('X (m)')
ylabel('Y (m)')

figure(2)
plot(0:20,positions(1,:),'r-',0:20,positions(2,:),'g-',0:20,positions(3,:),'b-')
title('End-effector position in x(red), y(green) and z(blue) in meters')
xlabel('Time (s)')
ylabel('Position value (m)')

figure(3)
plot(0:20,angles(1,:),'r-',0:20,angles(2,:),'g-',0:20,angles(3,:), ...
    'b-',0:20,angles(4,:),'k-')
title('Joint 1(red), 2(green), 3(blue) and 4(black) values')
xlabel('Time (s)')
ylabel('Angle (rad) / Length (m)')