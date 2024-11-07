% Screw axes by column
S=[[0 0 1 0 0 0]' [0 0 -1 0.3 0 0]' [0 0 0 0 0 1]' ...
   [1 0 0 0 0.8 0]' [0 0 1 0 -0.3 0]' [1 0 0 0 0.6 0]'];
omghat=S(1:3,:); % Extracting rotational axes
vhat=S(4:6,:); % Extracting linear velocities

% Recording end-effector positions
positions=[];

% Taking 22.5° steps for every rovolute (and 0.05m for the prismatic) joint
for a=0:22.5:180
    for b=0:22.5:180
        for c=0:0.05:0.2
            for d=0:22.5:180
                for e=0:22.5:180
                    for f=0:22.5:180

theta=[deg2rad(a) deg2rad(b) c deg2rad(d) deg2rad(e) deg2rad(f)];

Tse=[eye(4)];

% Multiplying all matrix logarithms together
for i=1:6
    Tse=Tse*MatrixExp6([VecToso3(omghat(:,i)) [omghat(:,i)]; 0 0 0 0]...
        *theta(i));
end

Tse=Tse*[rotz(deg2rad(-90)) [0.7 0 0.6]'; 0 0 0 0];

positions(1:3,end+1)=Tse(1:3,4);
                    end
                end
            end
        end
    end
end

% Plotting end-effector positions
plot3(positions(1,:),positions(2,:),positions(3,:),'bx')
axis equal
xlabel('X')
ylabel('Y')
zlabel('Z')
title('Workspace')
hold on
trplot(eye(4),'color','r','frame','{s}')