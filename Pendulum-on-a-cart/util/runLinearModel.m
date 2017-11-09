clear

% Define the system
%%
sys = LinearPendulumCartSystem(1);

%% Initialize Parameter
A = sys.Amatrix;
B = sys.Bmatrix;

if 1
% LQR
nx = size(A,2);
nu = size(B,2);
Q = eye(nx)*10;
% Q = [100 0 0 0; 0 1 0 0; 0 0 100 0; 0 0 0 1];
R = eye(nu)*1;
N = zeros(nx, nu);
[~, ~, k] = care(A, B, Q, R, N);

% Lyapunov Function
P = lyap((A - B*k)', Q)'
else
% Pole Placement
p = [-1 -3i 3i -2];
k = place(A,B,p);
end

x0 = [-1 0 0 0]';
x0(1) = x0(1);

data1 = load('ResponseLinearOrbit16-Jun-2017_10');
% data2 = load('ResponseLinearOrbit16-Jun-2017_20');
data2 = load('ResponseLinearOrbit17-Jun-2017_20');
Orbit.data1.states = data1.response.states{1};
Orbit.data1.input = data1.response.inputs{1};
Orbit.data2.states = data2.response.states{1};
Orbit.data2.input = data2.response.inputs{1};

createBusObject(Orbit, 'OrbitBus');
%%
sim('linearSimMPC')

%%
% Simulate upright from perturbed initial conditions
% x = logsout.getElement('x');
x = logsout.getElement('x_equ');
responseSim = [];
responseSim.time{1} = x.Values.Time;
responseSim.x{1} = x.Values.Data;
responseSim.x{1}(:,2) = responseSim.x{1}(:,2) + pi/2;
responseSim.eval = @(t)interp1(responseSim.time{1}, responseSim.x{1}, t);

% Construct and play animation
scene = PendulumCartScene(sys, responseSim);
Player(scene, [], [], []);
movegui(gca,[2000,0])

%% Plot Control Lyapunov Function

x0 = x.Values.Data';
V = [];
for i = length(x0):-1:1
	V(i) = x0(:,i)'*P*x0(:,i);
end
figure
plot(V)


