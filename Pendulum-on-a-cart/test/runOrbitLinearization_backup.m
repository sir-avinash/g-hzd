sys = PendulumCartSystem(1);

%%
data = load('ResponseOrbit10-Feb-2017_1');
[tStar, xStar, uStar, mStar] = data.response.unpack;

%%
sys_cl = closeLoopSystem(t, x, sys, data);

%%
x0 = [0 pi/2 0 0]';
x0(1) = x0(1) + 1;
x0(2) = x0(2) + deg2rad(30);
t_span = 0:1e-3:20;
[T, X] = ode45(@(t, x)closeLoopSystem(t, x, sys, data), t_span, x0);
for i = length(T):-1:1
	[~, u] = closeLoopSystem(T(i), X(i,:)', sys, data);
	U(i) = u;
end
%%
figure; plot(T, X)
figure; plot(T, U)
%%
figure; plot(T(14e3:10: 20e3) - T(14e3), X(14e3:10: 20e3, :))
hold on;
plot(tStar{1}, xStar{1})
hold off;

%%
figure; plot(T(14e3:10: 20e3) - T(14e3), U(14e3:10: 20e3))
hold on;
plot(tStar{1}, uStar{1})
hold off;

%%

tStar = T(14e3: 10: 20e3) - T(14e3);
xStar = X(14e3: 10: 20e3, :);
uStar = U(14e3: 10: 20e3);

%%

AclFcn = @(x,u,m,it)fcnJacobian(@(x)closeLoopSystem(interp1(1:120, tStar{1}, it), x, sys, data),x);

%%
im = 1;
Acl = [];
for it = 120:-1:1
Acl(:,:,it) = AclFcn(xStar{im}(:,it), uStar{im}(:,it), mStar, it);
end % for

%%
Phi0 = eye(4);
PhiT = eye(4);
for i = 1:4
% i = 1;
x0 = Phi0(:,i);
t_span = 0:1e-3:2;
[T, X] = ode45(@(t, x)transitionFunAcl(t, x, Acl), t_span, x0);
xT = X(end,:)';
PhiT(:,i) = xT;
end

eig_Phi = eig(PhiT)

%%
x0 = [1 0 0 0]';
t_span = 0:1e-3:20;
[T, X] = ode45(@(t, x)transitionFunAcl(t, x, Acl), t_span, x0);
figure; plot(X)



%%
[AFcn, BFcn, CFcn, DFcn] = sys.linearize;

%%
uFcn = @(x,u,m,it)fcnJacobian(@(x)nnControllerOrbitTime([x; interp1(1:120, rem(linspace(0,6,120),2), it)]),x);



%%
im = 1;
A = [];
B = [];
K = [];
for it = 120:-1:1
A(:,:,it) = AFcn(xStar{im}(:,it), uStar{im}(:,it), mStar);
B(:,:,it) = BFcn(xStar{im}(:,it), uStar{im}(:,it), mStar);
K(:,:,it) = uFcn(xStar{im}(:,it), uStar{im}(:,it), mStar, it);
end % for

%%
x0 = [1 0 0 0]';
t_span = 0:1e-3:2;
[T, X] = ode45(@(t, x)transitionFun(t, x, A, B, K), t_span, x0);
figure; plot(X)


%%
Phi0 = eye(4);
PhiT = eye(4);
for i = 1:4
% i = 1;
x0 = Phi0(:,i);
t_span = 0:1e-3:2;
[T, X] = ode45(@(t, x)transitionFun(t, x, A, B, K), t_span, x0);
xT = X(end,:)';
PhiT(:,i) = xT;
end

eig_Phi = eig(PhiT)

%%
Phi0 = eye(2);
PhiT = eye(2);
for i = 1:2
% i = 1;
x0 = Phi0(:,i);
t_span = 0:1e-3:2;
[T, X] = ode45(@(t, x)transitionFun_reduced(t, x, A, B, K), t_span, x0);
xT = X(end,:)';
PhiT(:,i) = xT;
end

eig_Phi = eig(PhiT)