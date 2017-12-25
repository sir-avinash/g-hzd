function h_alpha = UpdateBezierFirstTwoDDA(q,dq,ControlState,ControlParams,ControlSwitch,h_alpha, yminus, dyminus, Tau)

[q, dq, qHip, dqHip, qLegS, dqLegS, qLegS_prev, dqLegS_prev, qRoll,dqRoll,~]  = Update_q(q,dq,ControlState,ControlParams);

[Tzero,Tact,Tbzero,Tbact] = ATRIAS2D_ZD_TransformBAG;
T=[Tzero;Tact]; Tb=[Tbzero;Tbact]; 
T0=inv(T);
T1=-T0*Tb;

qbar=T*q+Tb;
dqbar=T*dq;
qact=qbar(2:5);
dqact=dqbar(2:5);
qzero=qbar(1);
dqzero=dqbar(1);

theta_limits = ControlParams.Output.ThetaLimits;
[s,ds,th,dth,delta_theta,c]=ATRIAS2D_SS_s_RigidBAG(3*pi/2+[-1 -0.5 -0.5]*qLegS ,3*pi/2+[-1 -0.5 -0.5]*dqLegS,theta_limits);
[s_prev,~,~,~,~,~]=ATRIAS2D_SS_s_RigidBAG(3*pi/2+[-1 -0.5 -0.5]*qLegS_prev ,3*pi/2+[-1 -0.5 -0.5]*dqLegS_prev,theta_limits);

% yminus = get_yminus(qminus,dqminus,qHipminus,h_alpha,theta_limits);

% yminus comes from the controller output and then swap the ordinate
yminus = yminus([2,1,4,3,6,5],:);
delta_s = 1-(s_prev-s);

if ControlSwitch == 1
h_alpha = halphaColumnShiftReset( h_alpha, s, [qact;qHip], yminus);
end

t_norm = 0.5;

% -- Roll Update -- (May not use)
% Pure Step Base
gamma_norm = -0.0873;
% gamma_norm = 0.0873;
gamma_gain = (-0.1745-0)/0.4*0;
h_alpha(6,6) = gamma_norm-gamma_gain*(t_norm-Tau);
% h_alpha(6,6) = gamma_norm+gamma_gain*(Tau-t_norm)+gamma_gain*5*(Tau-t_norm).^2.*(Tau>t_norm)-gamma_gain*5*(Tau-t_norm).^2.*(Tau<t_norm);

% Bezier
% gamma2_gain = -0.3054;
% gamma1_gain = -0.2443;
% h_alpha(6,:) = h_alpha(6,:) + [0 0 0 0 gamma1_gain*(t_norm-Tau)+gamma1_gain*5*(t_norm-Tau).^2 gamma2_gain*(t_norm-Tau)+gamma2_gain*5*(t_norm-Tau).^2];

% -- Swing Leg Update --
beta2_gain = 0.4363;    % 5 deg gain
beta1_gain = 0.3491;    % 4 deg gain

% Tau = Tau/(1+sqrt((1-s)));
% Tau = Tau*(1-sqrt(delta_s));
Tau = min(max(Tau,t_norm-0.25),t_norm+0.25);
kd = 3;

% update the last two column to extend or retract the swing leg, depending
% on the last-step time
h_alpha(2,:) = h_alpha(2,:) + [0, 0, 0, 0,...
    beta1_gain*(t_norm-Tau)+beta1_gain*kd*(t_norm-Tau).^2.*(Tau>t_norm)-beta1_gain*kd*(t_norm-Tau).^2.*(Tau<t_norm),...
    beta2_gain*(t_norm-Tau)+beta2_gain*kd*(t_norm-Tau).^2.*(Tau>t_norm)-beta2_gain*kd*(t_norm-Tau).^2.*(Tau<t_norm)];

% h_alpha(2,:) = h_alpha(2,:) + [0, 0, 0, 0,...
%     beta1_gain*(t_norm-Tau)+beta1_gain*kd*(t_norm-Tau).^2,...
%     beta2_gain*(t_norm-Tau)+beta2_gain*kd*(t_norm-Tau).^2];

% -- Stance Knee Update -- (May not use)
zeta_norm = 0.0873; % inward 5 deg
% zeta_norm = -0.0873; % outward 0 deg
zeta = qRoll+qHip(1);
zeta = min(max(zeta,zeta_norm-0.0873),zeta_norm+0.0873);

beta3_gain = 0.4363*2;
% h_alpha(3,:) = h_alpha(3,:) + [0 0 beta3_gain*(zeta_norm-zeta) 0 0 0];

% +beta3_gain*(zeta_norm-zeta).^2
end

% function yminus = get_yminus(qminus,dqminus,qHipminus,h_alpha,theta_limits)
% 
% 
% [Tzero,Tact,Tbzero,Tbact] = ATRIAS2D_ZD_TransformBAG;
% T=[Tzero;Tact]; Tb=[Tbzero;Tbact]; 
% T0=inv(T);
% T1=-T0*Tb;
% 
% qbar=T*qminus+Tb;
% dqbar=T*dqminus;
% qact=qbar(2:5);
% dqact=dqbar(2:5);
% qzero=qbar(1);
% dqzero=dqbar(1);
% 
% % theta_limits = ControlParams.Output.ThetaLimits;
% [s,ds,th,dth,delta_theta,c]=ATRIAS2D_SS_s_RigidBAG(qzero,dqzero,theta_limits);
% 
% yminus = [qact;qHipminus] - bezier(h_alpha,s);
% 
% 
% end

