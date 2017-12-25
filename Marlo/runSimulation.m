%RUNSIMULATION Runs the feedback controller.
%
% Copyright 2013-2014 Mikhail S. Jones
% Modified, 11-17-2015 Dennis Da

% Clean up the workspace
clear all; 
clc; close all

addpath ../
% Construct system model
sys = AtriasSystem;
controlSys = SimControllerHZD;

% HZD
load Response28-Oct-2016_day_l0_40_l1_70_h0_-25_h1_25_periodic.mat
tic

x0 = response.eval(0);
t0_step = response.time{1}(end);

% ===Gait Library Input===
% load('Gait_Library_24-Oct-2016_2StepsHeightPeriodic_good');
load('Gait_Library_28-Oct-2016_2StepsLengthHeightPeriodic_good');
hAlphaSet = AlphaSet;
thetaSet = thetaAlpha;

% Nstep = 1;%120;	% number of steps to run

%% ===Ground Profile===
for i=1:20
    ld_min=0.3; ld_max=0.8;
    hd_min=-0.3; hd_max=0.3;
    controller.CBF_ld(i)=ld_min+rand*(ld_max-ld_min);
    controller.CBF_hd(i)=hd_min+rand*(hd_max-hd_min);
end


ld_set=controller.CBF_ld
hd_set=controller.CBF_hd
controller.stone_size=0.25/2;
% controller.CBF_ld=[0.3;0.45;0.5];
% controller.CBF_hd=[-0.08;-0.05;-0.1];

Nstep=length(controller.CBF_ld);
stone_x=zeros(Nstep,1);
stone_y=zeros(Nstep,1);
stone_x(1)=controller.CBF_ld(1);
stone_y(1)=controller.CBF_hd(1);
for i=2:Nstep
    stone_x(i)=stone_x(i-1)+controller.CBF_ld(i);
    stone_y(i)=stone_y(i-1)+controller.CBF_hd(i);
end
interval = 0.01;
stepLength = -10:interval:100;
stepHeight = -1*ones(1,length(stepLength));

stepHeight(stepLength<=controller.stone_size)=0;
stepHeight(stepLength<=-controller.stone_size)=-0.5;
% stepHeight(stepLength<=-controller.CBF_ld(1)+controller.stone_size)=controller.CBF_hd(1);
for i=1:Nstep
    for j=1:length(stepLength)
        if (stepLength(j)>=stone_x(i)-controller.stone_size)&&(stepLength(j)<=(stone_x(i)+controller.stone_size))
            stepHeight(j)=stone_y(i);
        end
    end
end

shape = 'nearest';

% stepLength = 1:1:10;
% stepHeight = [1 0 1 0 1 0 1 0 1 0]*0.2;
% shape= 'previous';
%%
x0(2) = x0(2) + interp1(stepLength,stepHeight,0,shape);
% x0(1) = 0;

%% controller set up
% PD controller
controller.Kp = 80*20*eye(4)/7; %8000/50;%
controller.Kd = 20*5*eye(4)/7; %300/50;%
% A = [zeros(4) eye(4);
%      -controller.Kp  -controller.Kd] ;
%  controller.Q_pd = eye(8) ;
%  controller.P_pd = lyap(A', controller.Q_pd) ;
%  controller.gamma_pd  = min(eig(controller.Q_pd))/max(eig(controller.P_pd));
    
% params for LQR controller
F = [zeros(4), eye(4);
     zeros(4), zeros(4)];
G = [zeros(4);
     eye(4)];
Q=10^4*diag([100,100,100,100,1,1,1,1]);
R=eye(4);
controller.K_lqr=lqr(F,G,Q,R);

% params for CLF from LQR controller
A = [zeros(4) eye(4);  
     -controller.K_lqr] ;
controller.P=lyap(A',Q);
controller.Q=Q; 
controller.gamma  = min(eig(controller.Q))/max(eig(controller.P));

ub=7;
controller.ub=ub;
controller.u_min = -ub*[1;1;1;1] ;
controller.u_max = ub*[1;1;1;1];

% params for CBF
controller.p1=0.001;
controller.CBF_gamma_b=100;%100;
controller.CBF_gamma=100;%50;
controller.CBF_R1=0.5;%0.5
controller.CBF_R2=2;%2;

controller.CBF_delta_l0=0.01; %0.01 % l0=ls_last-controller.CBF_delta_l0;

controller.CBF_soft_saturation=1;%1;
controller.hard_saturation=1;
% friction constraint
controller.CBF_friction_constraint=1;%1;
controller.friction_delta_a=150/63;%0.1
controller.friction_kf=0.6;

% other options
controller.saturate_s=1; % saturate phase variable s
controller.type='io';% pd; lqr; io; mn (min-norm); clf; cbf
controller.CBF_stepping_stone_constraint=0;
controller.Exp_CBF=1; % use exponential CBF
controller.gait_library='on'; % on/off
controller.dx_tgt_constant=0.4; % nominal step length if gait library 'off'

controller.break_sim=0; 
global sim_test
sim_test.fail=0;
% ===Run Simulation===
u = @(t,x,Nstep, stepHeight)controlSys.HZDfeedbackControl(t,x(1:7),x(8:14),...
	hAlphaSet,thetaSet,Nstep,controller);

[response,xMinus,y,dy,data,ls_last] = sys.simulate_old([0 2], x0, controller,...
	'initialMode', 'ss',...
	'controller',u,...
	'maxModes',Nstep,...
	'solver','ode15s',...
	'stepHeight',stepHeight,...
	'stepLength',stepLength,...
	'shape',shape,...
	'CheckEvent', true);
toc

if sim_test.fail==0
    disp('Success !!!');
else
    disp('Fail !!!')
end
    % Plot time response
% response.plot;
% ylim([-5 5])
% movegui(gca,[1300,0])

% Construct and play animation
scene = AtriasScene(sys, response);
% 
% shape='previous';
Player(scene, stepLength, stepHeight, shape);
% movegui(gca,[-2000,0])
controller.plot_circle_constraint=0;
make_plots(response,y,dy,data,controller,ls_last);
