
nLinks = 1;
sys = PendulumCartSystem(nLinks);


xGuess = [0 repmat(pi/2, 1, nLinks) 0 repmat(0, 1, nLinks)]';
uGuess = 0;
point = sys.fixedPoint(xGuess, uGuess);
%%
[AFcn, BFcn, CFcn, DFcn] = sys.linearize;

% Unpack trajectories from time point object
[x0, u0, m0] = point.unpack;

% Evaluate linearized dynamics at fixed point
A = AFcn(x0, u0, m0);
B = BFcn(x0, u0, m0);

%%
% Solve the continuous-time algebraic Riccati equations
% Number of states and inputs
nx = 4;
nu = 1;
Q = eye(nx);
R = eye(nu);
N = zeros(nx, nu);

[~, ~, k] = care(A, B, Q, R, N);


%%

linearizedSys = linearizeSystem(sys)

