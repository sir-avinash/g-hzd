
%% run simulation
% x0 = [0 pi/2 0 0]';
x0 = [0 0 0 0]';
x0(1) = x0(1) - 1;
x0(2) = x0(2) + deg2rad(15);
% x0(3) = x0(3) - 2;
% Taction = 0.5;

% L = zeros(2);
L = [0 0; 0 0.5911];	% library fitting 2second period
% L = [0.0316    0.1084; 0.0000    0.0000]; % back stepping Q = 1, R = 1000
H = [1 0 0 0; L(1,1) 0 L(1,2) 0; 0 0 1 0; L(2,1) 0 L(2,2) 0];
x0 = H*x0;

Taction = 2;
sim('nonlinearSimMPC')

%% run animation
sys = PendulumCartSystem(1);
% Simulate upright from perturbed initial conditions
x = logsout.getElement('x');
u = logsout.getElement('u');
responseSim = [];
responseSim.time{1} = x.Values.Time;
responseSim.x{1} = x.Values.Data;
responseSim.x{1}(:,2) = responseSim.x{1}(:,2);
responseSim.eval = @(t)interp1(responseSim.time{1}, responseSim.x{1}, t);

tSim = responseSim.time{1};
xSim = responseSim.x{1};
uSim = u.Values.Data;

%
% Construct and play animation
scene = PendulumCartScene(sys, responseSim);
Player(scene, [], [], []);
% movegui(gca,[2000,0])

%% Save log file to plot figure

% save('DataFiles\log\EquBack080917','logsout')
% save('DataFiles\log\nnEqu_full','logsout')
% save('DataFiles\log\nnEqu_fullMPC','logsout')
% save('DataFiles\log\nnOrbitLibrary090917','logsout')
% save('DataFiles\log\mpcController','logsout')

%% Plot data
figure(100)
plot(tStar, uStar)
hold on
plot(tSim, uSim)
hold off

figure(101)
plot(tStar, xStar)
hold on
plot(tSim, xSim)
hold off

