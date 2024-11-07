% Screw axes by column
S=[[0 0 1 0 0 0]' [0 0 -1 0.3 0 0]' [0 0 0 0 0 1]' ...
   [1 0 0 0 0.8 0]' [0 0 1 0 -0.3 0]' [1 0 0 0 0.6 0]'];
omghat=S(1:3,:); % Extracting rotational axes
vhat=S(4:6,:); % Extracting linear velocities
theta=[deg2rad(20) deg2rad(5) 0.1 deg2rad(30) deg2rad(-15) deg2rad(90)];

Tse=[eye(4)];

% Multiplying all matrix logarithms together
for i=1:6
    Tse=Tse*MatrixExp6([VecToso3(omghat(:,i)) [omghat(:,i)]; 0 0 0 0]...
        *theta(i));
end

Tse=Tse*[rotz(deg2rad(-90)) [0.7 0 0.6]'; 0 0 0 0]