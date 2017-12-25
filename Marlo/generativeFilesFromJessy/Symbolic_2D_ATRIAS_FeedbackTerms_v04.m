
%Symbolic_2D_ATRIAS_FeedbackTerms_v04.m

% April 29th, 2013 BAG Modified to remove springs and make system rigid as a learning excercise. 

clear all
disp('Cleared Workspace')

%load Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_Dynamic20120512T131252
%load Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_Dynamic20120715T134614
load Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_DynamicReduced

% base=pwd;  %%%% Allows the symbolic file to access ATRIAS2D_ZD_Transform
%            %%%% which has the coordinates for the output variables
           
setpath_simulator

% cd ..
% cd ATRIAS-2D_Simulator_RigidGround_NewParameters_v05
% setpath_simulator
% eval(['cd ',base])

if 0
    %h0=[Torso, stance knee, swing leg angle, swing knee]
    h0=[qT; q2-q1 ; (q1L+q2L)/2; q2L-q1L];
    
elseif 0
    qLA=(q1+q2)/2; qLA_L= (q1L+q2L)/2;
    th1 = pi - (qLA + qT);  th2=pi -(qLA_L + qT);
    
    %h0=[Torso, stance leg mirror image of swing leg, stance knee,  swing knee]
    h0=[qT;  th1+th2 ; q2-q1 ; q2L-q1L];
    
elseif 0
    qLA=(qgr1+qgr2)/2; qLA_L= + (qgr1L+qgr2L)/2;
    th1 = pi - (qLA + qT);  th2=pi -(qLA_L + qT);
    %h0=[Stance Leg angle, stance leg angle + swing leg angle, stance knee,  swing knee]
    h0=[qLA;  th1+th2 ; qgr2-qgr1 ; qgr2L-qgr1L];
    
elseif 0
    
    h0=[qgr1; qgr2; qgr1L; qgr2L];
    
elseif 0  %% 14 May 2011
    qLA=(qgr1+qgr2)/2; qLAL= (qgr1L+qgr2L)/2;
    qKnee=qgr2-qgr1; qKneeL=qgr2L-qgr1L;
     %h0=[Stance Leg angle, Swing leg angle , stance knee,  swing knee]
    h0=[qLA; qLAL; qKnee; qKneeL];
    
else %% 12 May 2012
   [Tzero,Tact,Tbzero,Tbact] = ATRIAS2D_ZD_Transform;
   h0=Tact*q+Tbact;
    
    
end

disp('Commanded output')
h0

h0_leg0=h0;
h0_leg1=h0;


jacob_h0_leg0=jacobian(h0_leg0,q);
jacob_jacobh0dq_leg0=jacobian(jacob_h0_leg0*dq,q);

jacob_h0_leg1=jacobian(h0_leg1,q);
jacob_jacobh0dq_leg1=jacobian(jacob_h0_leg1*dq,q);

Work_name3=[Work_name2,'Jacobians4Feedback'];
eval(['save  ',Work_name3])

fcn_name='ATRIAS2D_Fdbk_Terms';
generate_fdbk_terms