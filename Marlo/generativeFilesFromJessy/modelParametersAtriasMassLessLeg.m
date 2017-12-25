function [g mTotal m1 m2 m3 m4 mH mT L1 L2 L3 L4 LT W] = modelParametersAtriasMassLessLeg
% April 3rd, 2013 BAG Modified to remove springs and make system rigid as a learning excercise. 
%
%
%Model parameters for 3D ATRIAS.
%
%Grizzle estimated these values on 30 October 2010

% 2015-07-10 DDA
% update parameter based on ATRIAS3D_Physic with FT
%
%
%Gravity
g=9.81; %m/s^2 

%Leg data
L1=0.5; %m
L2=0.5;
L3=0.5;
% L4=0.615;
L4=0.5;

% m1=0.7671+1.9793; %kg shin and spring mass
% m2=0.7555+1.9613;
% m3=0.646;
% m4=1.64; % Probably lower leg

% massless leg
m1=1e-3; %kg shin and spring mass
m2=1e-3;
m3=1e-3;
m4=1e-3; % Probably lower leg

% Hip data  %%Note that in the planar modoel, the torso and hip are a
% single unit
mH = 2*15.8; %kg Mass of Hip

% Torso Data
LT=0.58; %m
% mT=34.83; %kg Mass of Torso (CAD)
% mT = 16.3106;    %(Measurement)

mT = 16.3106+6; % DDA calibrate based on mTotal = 140 lb

% Hip Data
W=0.18; %m

mTotal = 2*(m1 + m2 + m3 + m4) + mT + mH;

end