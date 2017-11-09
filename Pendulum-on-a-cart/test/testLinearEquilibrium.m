clear

% Define the system
% sys = PendulumCartSystem(1);
sys = LinearPendulumCartSystem(1);

%% Import controllers

% data = load('ResponseOrbit10-Feb-2017_1');
% Orbitstates = data.response.states{1};
% Orbitstates(2,:) = Orbitstates(2,:) - pi/2;
% controller = @(t,x, Nstep, stepHeight)ControllerOrbitTimestate(t, x, Orbitstates);

A = sys.Amatrix;
B = sys.Bmatrix;
nx = size(A,2);
nu = size(B,2);
Q = eye(nx)*100;
R = eye(nu)*1;
N = zeros(nx, nu);
[~, ~, k] = care(A, B, Q, R, N);
controller = @(t,x, Nstep, stepHeight)ControllerLinearEqu(t, x, k);
%%
% Simulate upright from perturbed initial conditions
% x0 = response.states{1}(:,1);
x0 = [0 0 0 0]';

x0(1) = x0(1) + 1;
x0(2) = x0(2) + deg2rad(30);
% x0(3) = x0(3) - 0.5;
% x0(4) = x0(4) - deg2rad(20);

[responseSim,xMinus,output_Data] = sys.simulate([0 10], x0, ...
	'Controller', controller,...
	'maxModes',1);

% Plot time response
responseSim.plot;
% movegui(gca,[2000,0])

% Construct and play animation
scene = LinearPendulumCartScene(sys, responseSim);
Player(scene, [], [], []);
movegui(gca,[2000,0])

%%
x_head = [output_Data{1}.x_head]';
x = [output_Data{1}.x]';

figure
subplot(211)
plot(responseSim.time{1}, x(:,1))
hold on
plot(responseSim.time{1}, x_head(:,1),'--')
hold off
% title('Cart Velocity')
title('Cart Position')
subplot(212)
plot(responseSim.time{1}, x(:,2)*180/pi-90)
hold on
plot(responseSim.time{1}, x_head(:,2)*180/pi-90,'--')
hold off
title('$\theta$')