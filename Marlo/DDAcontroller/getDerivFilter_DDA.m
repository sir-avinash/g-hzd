function FiltSys = getDerivFilter_DDA(R, Q, Ts)
% Create a Kalman Filter state space model to estimate velocity. R and Q
% are weight scale value. R is the noise weight from state input and Q is
% the noise weight from measurement. For tuning perspect, lower Q gets less
% filter effect and larger Q gets smoother data but also more time delay.
% Range of Q could from 0.0010 to 1.5734e+11. R could just leave to be a
% constant. Ts is the sample time of the simulink model.

% Ts = 5e-4;
% Ts = 5.0210e-04;    % current sample time (default)

% == State Space Model ==
% -- Continuous --
% A = [0 1 0; 0 0 1; 0 0 0];
% B = [0;0;1];
% C = [1 0 0];
% D = 1;

% -- Discrete --
Ad = [1 Ts .5*Ts^2; 0 1 Ts;0 0 1];
Bd = [Ts^3/6; Ts^2/2; Ts];
Cd = [1 0 0];
dCd = [0 1 0];
% Dd = D;

%% == Reference ==
P0 = 100;

% std_w = 1/Ts^2;
% R = std_w^2/10;    % state noise (default)
% Q = Ts/100;        % output noise (default)
% Q = 1.5e3;    % filter out more frequency

% == Calculate the filter gain ==
K1 = ones(3,1);
delta = 1;
while delta > 1e-8
    K0 = P0*Cd'/(Cd*P0*Cd'+Q);
    P0 = P0 - K0*Cd*P0;
    P1 = Ad*P0*Ad'+Bd*R*Bd';
    P0 = P1;
    delta = norm(K1-K0);
    K1 = K0;
end

%% == Construct Kalman Filter State Space Form ==
FiltSys.A = Ad*(eye(3)-K0*Cd);
FiltSys.B = Ad*K0;
FiltSys.C = dCd;
FiltSys.D = 0;
FiltSys.x0 = [0;0;0];
FiltSys.dt = Ts;