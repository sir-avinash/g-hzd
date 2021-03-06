function [v]=control_two_link(H,LfH)
% CONTROL_TWO_LINK    Calculate the control.
%    [V] = CONTROL_TWO_LINK(X,H,LFH) is the control for the
%    feedback linearized biped walking model.
%

% Eric Westervelt
% 20-Feb-2007 10:18:18

[th1d,alpha,epsilon]=control_params_two_link;

% LfH scaling
LfH=epsilon*LfH;

% phi fcns
phi1=H(1)+1/(2-alpha)*sign(LfH(1))*abs(LfH(1))^(2-alpha);

% psi fcns
psi(1,1)=-sign(LfH(1))*abs(LfH(1))^alpha...
         -sign(phi1)*abs(phi1)^(alpha/(2-alpha));

% calculate control
v=1/epsilon^2*psi;
