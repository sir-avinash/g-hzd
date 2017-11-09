
% x0 = [0 pi/2 0 0]';
x0 = [0 0 0 0]';
x0(1) = x0(1) - 1;
x0(2) = x0(2) + deg2rad(15);
% x0(3) = x0(3) - 1;

nNodes = 120 + 1;
% nNodes = 12000 + 1;

L = zeros(2);
% L = [pi/15 pi/15; 0 0];
% L = [0.1744 0.0437; 0.2531 0.0624];
H = [1 0 0 0; L(1,1) 0 L(1,2) 0; 0 0 1 0; L(2,1) 0 L(2,2) 0];
% x0 = H*x0;

[~, ~, tStar, xStar, uStar] = funEquilibrium(x0, nNodes, L);
%
Taction = .1;
sim('nonlinearSim')

%%
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

%%
% save('DataFiles\log\EquBack080917','logsout')
% save('DataFiles\log\nnEqu_full','logsout')
% save('DataFiles\log\nnEqu_fullMPC','logsout')
% save('DataFiles\log\nnOrbitLibrary090917','logsout')
% save('DataFiles\log\mpcController','logsout')

%%
% figure(100)
% plot(tStar, uStar)
% hold on
% plot(tSim, uSim)
% hold off
% 
% figure(101)
% plot(tStar, xStar)
% hold on
% plot(tSim, xSim)
% hold off

