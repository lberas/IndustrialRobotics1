% Screw axes by column
S=[[0 0 1 0 0 0]' [0 0 -1 0.3 0 0]' [0 0 0 0 0 1]' ...
   [1 0 0 0 0.8 0]' [0 0 1 0 -0.3 0]' [1 0 0 0 0.6 0]'];
omghat=S(1:3,:); % Extracting rotational axes
vhat=S(4:6,:); % Extracting linear velocities
theta=[0 0 0 0 0 0]; % Initial joint positions
theta_dot=[deg2rad(20) deg2rad(2) 0 deg2rad(10) 0 0]; % Joint velocities (in rad/s or m/s)

% Recording end-effector positions
positions=[];

for t=0:0.1:4 % Start time:Time step:End Time

    Tse=[eye(4)];

    % Multiplying all matrix logarithms together
    for i=1:6
        Tse=Tse*MatrixExp6([VecToso3(omghat(:,i)) [omghat(:,i)]; 0 0 0 0]...
            *theta(i));
    end

Tse=Tse*[rotz(deg2rad(-90)) [0.7 0 0.6]'; 0 0 0 0];

positions(1:3,end+1)=Tse(1:3,4);

theta=theta+theta_dot*0.1; % Advancing joint positions

end

% Plotting end-effector trajecotry
figure(1)
plot3(positions(1,:),positions(2,:),positions(3,:),'bx')
axis equal
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Trajectory')
hold on
trplot(eye(4),'color','r','frame','{s}')

% Plotting end-effector positions
figure(2)
plot(0:0.1:4,positions(1,:),'r-',0:0.1:4,positions(2,:),'g-',...
    0:0.1:4,positions(3,:),'b-')
title('End-effector position in x(red), y(green) and z(blue) in meters')
xlabel('Time (s)')
ylabel('Position value (m)')