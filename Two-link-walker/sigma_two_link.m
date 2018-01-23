function [x]=sigma_two_link(a)
% SIGMA_TWO_LINK    Maps velocity of stance leg just before
%         impact to state of the system just before impact.
%    [X] = SIGMA_TWO_LINK(OMEGA_1_MINUS,A)

% Eric Westervelt
% 20-Feb-2007 10:18:18

[th1d,alpha,epsilon,dth1d]=control_params_two_link;

a02=a(1); a12=a(2); a22=a(3); a32=a(4);

% th1=th1d;
% dth1=dth1d;

th1 = a(5);
dth1 = a(6);

dth2 = -(1-3*a12*th1^2+a12*th1d^2-4*a22*th1^3+2*a22*th1*th1d^2-5*a32*th1^4+3*a32*th1^2*th1d^2-2*a02*th1)*dth1;

x = [th1,-th1,dth1,dth2];