% trajectory definition
n_points = 100;

global crossTrackErr;
global CTEIndx;

CTEIndx = 1;
% first phase
theta1 = linspace(pi/4, 0, n_points); R1 = 60;
phase1x = R1*cos(theta1); phase1y = R1*sin(theta1);

% second phase
theta2 = linspace(-pi,0,n_points); R2 = 3;
phase2x = 63 + R2*cos(theta2); phase2y = R2*sin(theta2);

% third phase
theta3 = linspace(0, pi, n_points); R3 = 20;
phase3x = 86 + R3*cos(theta3); phase3y = R3*sin(theta3);

% fourth phase

traj = [phase1x, phase2x, flip(phase3x); phase1y, phase2y, flip(phase3y)];
%traj = [phase1x, phase2x, phase3x;phase1y, phase2y, phase3y];

plot(traj(1,:), traj(2,:), 'r', 'LineWidth', 1.5);
hold on
axis equal
grid on

L1 = 7;

% setting up inegration
x0 = R1*cos(pi/4); y0 = R1*sin(pi/4) - 5;
X0 = [x0;y0;5;5]; tspan = [0,15]; dt_inv = 1000;

[state, L1] = simulate_system(X0, tspan, traj, L1(1));

plot(state(:,1), state(:,2), 'b', 'Linewidth', 1.0);
legend("Reference", "Actual");
xlabel("$x$ (m)", 'Interpreter', 'latex'); ylabel("$y$ (m)", 'Interpreter', 'latex');
set(gca, 'TicklabelInterpreter', 'latex');
% title("Modified L1, wind in -ve y direction")

theta_temp = linspace(0, pi/2, 1000);
theta_temp2 = linspace(0, 2*pi, 100);
% plot(R1*cos(theta_temp), R1*sin(theta_temp), '--r'); 
% plot(63 + R2*cos(theta_temp2), R2*sin(theta_temp2), '--r'); 

hold off