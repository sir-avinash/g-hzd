
x0 = [1 0 0 0]';
nNodes = 200;
[response, sys] = funEquilibrium(x0, nNodes);

[tStar, xStar, uStar, mStar] = response.unpack;

tStar = tStar{1};
uStar = uStar{1};
xStar = xStar{1};

%%

controller = @(t,x, Nstep, stepHeight)ControllerInterpolation(t, x, tStar, uStar);

[responseSim,xMinus,output_Data] = sys.simulate([0 2], x0 + [0 pi/2 0 0]', ...
	'Controller', controller,...
	'maxModes',1);

%
tSim = responseSim.time{1};
uSim = responseSim.inputs{1};
xSim = responseSim.states{1};

%%
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

%%
% % Plot time response
% responseSim.plot;
% % movegui(gca,[2000,0])
% 
% % Construct and play animation
% scene = PendulumCartScene(sys, responseSim);
% Player(scene, [], [], []);
% movegui(gca,[2000,0])