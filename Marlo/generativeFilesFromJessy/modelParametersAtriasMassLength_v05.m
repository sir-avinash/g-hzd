function [g mTotal m1 m2 m3 m4 mH mT L1 L2 L3 L4 LT W] = modelParametersAtriasMassLength_v05
% April 3rd, 2013 BAG Modified to remove springs and make system rigid as a learning excercise. 
%
%
%Model parameters for 3D ATRIAS.
%
%Grizzle estimated these values on 30 October 2010
%
%
%Gravity
g=9.81; %m/s^2 

%Leg data
L1=0.45; %m
L2=0.5;
L3=0.5;
L4=0.5;

m1=0.66149; %kg Maybe four bar linkage (0.6460 in PowerPoint)
m2=0.68292;
m3=0.19126;
m4=0.42493; % Probably lower leg

% Hip data  %%Note that in the planar modoel, the torso and hip are a
% single unit
mH = 2*12.84; %kg Mass of Hip

% Torso Data
LT=0.8; %m
mT=34.83; %kg Mass of Torso (CAD)
% mT = 16.3106;    %(Measurement)

% Hip Data
W=0.165; %m

mTotal = 2*(m1 + m2 + m3 + m4) + mT + mH;

end