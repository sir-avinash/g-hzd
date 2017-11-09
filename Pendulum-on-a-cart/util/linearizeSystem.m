function linearizedSys = linearizeSystem(sys)


linearizedSys.A = [];
linearizedSys.B = [];
linearizedSys.k = [];
	
nLinks = sys.nLinks;

% xGuess = [0 repmat(pi/2, 1, nLinks) 0 repmat(0, 1, nLinks)]';
xGuess = [0 repmat(0, 1, nLinks) 0 repmat(0, 1, nLinks)]';
uGuess = 0;
point = sys.fixedPoint(xGuess, uGuess);
%%
[AFcn, BFcn, CFcn, DFcn] = sys.linearize;

% Unpack trajectories from time point object
[x0, u0, m0] = point.unpack;

% Evaluate linearized dynamics at fixed point
A = AFcn(x0, u0, m0);
B = BFcn(x0, u0, m0);

linearizedSys.A = A;
linearizedSys.B = B;
