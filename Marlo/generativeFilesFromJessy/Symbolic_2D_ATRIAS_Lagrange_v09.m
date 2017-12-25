% Modified April 9th, 2013 BAG for learning excercise
% Symbolic_2D_ATRIAS_Lagrange_v09.m
%
% Reflects correction of error in torso mass

clear all
disp('Cleared Workspace')

syms g L1 L2 L3 L4 m1 m2 m3 m4
syms Jcm1 Jcm2 Jcm3 Jcm4
syms ellycm1 ellycm2 ellycm3 ellycm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4
syms LT mT JcmT mH JcmH ellycmT  ellzcmT
syms K1 K2 Kd1 Kd2  %Spring constants and damping constants
syms Jrotor1 Jrotor2 Jgear1 Jgear2 R1  R2

syms qT yH zH dqT dyH dzH
syms q1  q2  dq1 dq2
syms q1L q2L dq1L dq2L
syms qm1  qm2  dqm1  dqm2
syms qm1L qm2L dqm1L dqm2L

syms qgr1  qgr2  dqgr1  dqgr2     %gear reducer coordinates; are probably better numerically
syms qgr1L qgr2L dqgr1L dqgr2L    %than the motor coordinates, due to the low inertia of the rotors


%springs:  0 = springs not included in stance leg of model, 1 = springs included in stance leg
%
%springsLeft:  0 = springs not included in swing leg of model, 1 = springs included in swing leg
%
%HipPositionChoice:
% 0 = fix pHip=[yH;zH]=[0;0]; useful for checking model in a
%     simple situation
% 1 = fix stance leg end at [0;0] and hips computed
%     from leg angles; normal SS model
% 2 = Attach extra coordinates [yLeg;zLeg] at end of stance leg so
%     that p4=[yLeg;zLeg] and hips are computed from leg angles
%     This gives the normal impact model
% 3 = Attach extra coordiantes at  [yH;zH] at the hip,
%     so pHip =[yH;zH]  Unsure where to use it, but
%     it seems like a nice idea.

if 0  % Fix the parameters for MEX files.
    %base_path='C:\d_drive\mat_docs\robot_dir\Robot_dir_newer\ATRIAS\2D-ATRIAS\2011\ATRIAS-2D_Simulator'
    base_path='D:\d_drive\mat_docs\robot_dir\Robot_dir_newer\ATRIAS\2D-ATRIAS\2011\ATRIAS-2D_Simulator'
    addpath([base_path,'\ModelParameters'])
    [g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;
end

model_choices={'Dynamic' 'DynamicReduced' 'Impact' 'ImpactReduced', 'Flight', 'Dynamic_LeftStance'};  % add to list as needed

% which_model=char(model_choices(1));  %choose which model to build
which_model=char(model_choices(2));  %choose which model to build

Model=which_model;

switch lower(which_model)            %add cases as needed

    case {'dynamic'}  % Standard SS Model with stance on RIGHT Leg
        springs=1;
        springsLeft=1;
        HipPositionChoice=1;
        disp('Building SS Model')

    case {'dynamicreduced'}  % Reduced SS Model...no springs
        springs=0;
        springsLeft=0;
        HipPositionChoice=1; % Might have to modify hip position for cases
        disp('Building SS Model with No Springs')

    case {'impact'}  % Standard DS (impact) model
        springs=1;
        springsLeft=1;
        HipPositionChoice=2;
        disp('Building DS Impact Model')

    case {'impactreduced'}  % No springs in the impact model
        springs=0;
        springsLeft=0;
        HipPositionChoice=2;
        disp('Building DS Impact Model with No Springs')

    case {'flight'}  % Unconstrained or Flight Phase Model
        springs=0;
        springsLeft=0;
        HipPositionChoice=3;
        disp('Building Flight Phase Model')

    case {'dynamic_leftstance'}  % SS Model with Stance on LEFT Leg
        springs=1;
        springsLeft=1;
        HipPositionChoice=4;
        disp('Building SS Model')


    otherwise
        disp('Unknown Model Choice')
        return
end

if and(springs,springsLeft)
    q=[qT;q1;q2;qgr1;qgr2;q1L;q2L;qgr1L;qgr2L];
    dq=[dqT;dq1;dq2;dqgr1;dqgr2;dq1L;dq2L;dqgr1L;dqgr2L];
elseif springs
    q=[qT;q1;q2;qgr1;qgr2;q1L;q2L];
    dq=[dqT;dq1;dq2;dqgr1;dqgr2;dq1L;dq2L];
else
    q=[qT;q1;q2;q1L;q2L]; % this is the selected case, q and dq should be in R5.
    dq=[dqT;dq1;dq2;dq1L;dq2L];
end

R = inline('[cos(t) -sin(t); sin(t) cos(t)]');


th1=qT+q1;  %absolute orientation of link 1
th2=qT+q2;  %absolute orientation of link 2
dth1=dqT+dq1;
dth2=dqT+dq2;

th1L=qT+q1L;  %absolute orientation of link 1
th2L=qT+q2L;  %absolute orientation of link 2
dth1L=dqT+dq1L;
dth2L=dqT+dq2L;

% Set the Hip position
pHip = [yH; zH];
if HipPositionChoice == 1 % leg end is fixed % This should be how postitions are set up
    p1 = pHip + R(th1)*[0;L1];
    p2 = pHip +  R(th2)*[0;L2];
    p3 = p1 + R(th2)*[0;L3];
    p4 = p2 + R(th1)*[0;L4];
    pT = pHip + R(qT)*[0;LT];
    S=solve(p4(1),p4(2),'yH,zH');
    yH=S.yH; zH=S.zH;
    pHip=[yH;zH];
elseif HipPositionChoice == 0  %Hip position is fixed
    yH = 0*yH; zH = 0*zH;
    pHip = [yH;zH];
elseif HipPositionChoice == 3 % Hip position is free with coordinates [yH; zH]
    q=[yH;zH;q];
    dq=[dyH;dzH;dq];
elseif HipPositionChoice == 2 % leg end is [yLeg,zLeg]
    p1 = pHip + R(th1)*[0;L1];
    p2 = pHip +  R(th2)*[0;L2];
    p3 = p1 + R(th2)*[0;L3];
    p4 = p2 + R(th1)*[0;L4];
    pT = pHip + R(qT)*[0;LT];
    S=solve(p4(1),p4(2),'yH,zH');
    yH=S.yH; zH=S.zH;
    syms yLeg zLeg dyLeg dzLeg
    q=[yLeg;zLeg;q];
    dq=[dyLeg;dzLeg;dq];
    pHip=[yH;zH] + [yLeg;zLeg];
elseif HipPositionChoice == 4 % left leg end is fixed
    p1L = pHip + R(th1L)*[0;L1];
    p2L = pHip +  R(th2L)*[0;L2];
    p3L = p1L + R(th2L)*[0;L3];
    p4L = p2L + R(th1L)*[0;L4];
    pT = pHip + R(qT)*[0;LT];
    S=solve(p4L(1),p4L(2),'yH,zH');
    yH=S.yH; zH=S.zH;
    pHip=[yH;zH];
end

% position vectors relative to hip position
p1 = pHip + R(th1)*[0;L1]; p1 = simple(p1);
p2 = pHip +  R(th2)*[0;L2]; p2 = simple(p2);
p3 = p1 + R(th2)*[0;L3]; p3 = simple(p3);
p4 = p2 + R(th1)*[0;L4]; p4 = simple(p4);
pT = pHip + R(qT)*[0;LT]; pT=simple(pT);

disp('Stance leg end = p4 = [0,0] means standard SS model')
p4
disp('Hip position')
pHip

pcm1 = pHip + R(th1)*[ellycm1;ellzcm1];
pcm2 = pHip +  R(th2)*[ellycm2;ellzcm2];
pcm3 = p1 + R(th2)*[ellycm3;ellzcm3];
pcm4 = p2 + R(th1)*[ellycm4;ellzcm4];

pcmT = pHip + R(qT)*[ellycmT;ellzcmT];

p1L = pHip + R(th1L)*[0;L1]; p1L = simple(p1L);
p2L = pHip +  R(th2L)*[0;L2]; p2L = simple(p2L);
p3L = p1L + R(th2L)*[0;L3]; p3L = simple(p3L);
p4L = p2L + R(th1L)*[0;L4]; p4L = simple(p4L);

pcm1L = pHip + R(th1L)*[ellycm1;ellzcm1];
pcm2L = pHip +  R(th2L)*[ellycm2;ellzcm2];
pcm3L = p1L + R(th2L)*[ellycm3;ellzcm3];
pcm4L = p2L + R(th1L)*[ellycm4;ellzcm4];

Mtotal = mT + mH + 2*(m1 + m2 + m3 + m4);
pcm = (mT*pcmT + mH*pHip + m1*pcm1 + m2*pcm2 + m3*pcm3 + m4*pcm4 +  m1*pcm1L + m2*pcm2L + m3*pcm3L + m4*pcm4L)/Mtotal;
pcm=simple(pcm);
%velocities

vHip=jacobian(pHip,q)*dq;
vcm1=jacobian(pcm1,q)*dq;
vcm2=jacobian(pcm2,q)*dq;
vcm3=jacobian(pcm3,q)*dq;
vcm4=jacobian(pcm4,q)*dq;

vcmT=jacobian(pcmT,q)*dq;

vcm1L=jacobian(pcm1L,q)*dq;
vcm2L=jacobian(pcm2L,q)*dq;
vcm3L=jacobian(pcm3L,q)*dq;
vcm4L=jacobian(pcm4L,q)*dq;

disp('Key positions and velocities computed')

%% kinetic energy

KET=(1/2)*mT*vcmT.'*vcmT + (1/2)*JcmT*(dqT)^2;
KET=simplify(KET);

KEH=(1/2)*mH*vHip.'*vHip + (1/2)*JcmH*(dqT)^2;
KEH=simplify(KEH);

KE1=(1/2)*m1*vcm1.'*vcm1 + (1/2)*Jcm1*(dth1)^2;
KE1=simplify(KE1);

KE2=(1/2)*m2*vcm2.'*vcm2 + (1/2)*Jcm2*(dth2)^2;
KE2=simplify(KE2);

KE3=(1/2)*m3*vcm3.'*vcm3 + (1/2)*Jcm3*(dth2)^2;
KE3=simplify(KE3);

KE4=(1/2)*m4*vcm4.'*vcm4 + (1/2)*Jcm4*(dth1)^2;
KE4=simplify(KE4);

disp('KET through KE4 computed')

KE1L=(1/2)*m1*vcm1L.'*vcm1L + (1/2)*Jcm1*(dth1L)^2;
KE1L=simplify(KE1L);

KE2L=(1/2)*m2*vcm2L.'*vcm2L + (1/2)*Jcm2*(dth2L)^2;
KE2L=simplify(KE2L);

KE3L=(1/2)*m3*vcm3L.'*vcm3L + (1/2)*Jcm3*(dth2L)^2;
KE3L=simplify(KE3L);

KE4L=(1/2)*m4*vcm4L.'*vcm4L + (1/2)*Jcm4*(dth1L)^2;
KE4L=simplify(KE4L);

disp('KE1L through KE4L computed')

% Motor coordinates
if springs

else % gear variables are same as link variables
    qgr1=q1;
    qgr2=q2;
    dqgr1=dq1;
    dqgr2=dq2;
end

if springsLeft

else
    qgr1L=q1L;
    qgr2L=q2L;
    dqgr1L=dq1L;
    dqgr2L=dq2L;

end

qm1=qgr1*R1; % motor position related to _ by gear ratio
qm2=qgr2*R2;
qm1L=qgr1L*R1;
qm2L=qgr2L*R2;

dqm1=dqgr1*R1;
dqm2=dqgr2*R2;
dqm1L=dqgr1L*R1;
dqm2L=dqgr2L*R2;


thm1=qT+qm1; % absolute motor angular position
thm2=qT+qm2;
dthm1=dqT+dqm1;
dthm2=dqT+dqm2;

thm1L=qT+qm1L;
thm2L=qT+qm2L;
dthm1L=dqT+dqm1L;
dthm2L=dqT+dqm2L;

dthr1=dqT+dqgr1; % absolute gear reducer angular velocity
dthr2=dqT+dqgr2;
dthr1L=dqT+dqgr1L;
dthr2L=dqT+dqgr2L;

KEm1 = (1/2)*Jrotor1*(dthm1)^2 + (1/2)*Jgear1*(dthr1)^2;
KEm2 = (1/2)*Jrotor2*(dthm2)^2 + (1/2)*Jgear2*(dthr2)^2; % Other leg
KE_motorsRight = KEm1+KEm2;
KE_motorsRight=simple(KE_motorsRight);

KEm1L = (1/2)*Jrotor1*(dthm1L)^2 + (1/2)*Jgear1*(dthr1L)^2;
KEm2L = (1/2)*Jrotor2*(dthm2L)^2 + (1/2)*Jgear2*(dthr2L)^2;
KE_motorsLeft = KEm1L+KEm2L;
KE_motorsLeft=simple(KE_motorsLeft);

disp('KE of Motors and Gear Reducers computed')

KE_LegRight=KE1+KE2+KE3+KE4;
KE_LegRight=simplify(KE_LegRight);
%pretty(KE_LegRight);

KE_LegLeft=KE1L+KE2L+KE3L+KE4L;
KE_LegLeft=simplify(KE_LegLeft);

KE = KET + KEH + KE_motorsRight + KE_LegRight + KE_motorsLeft + KE_LegLeft;

disp('Total KE computed')

%% Compute D and C matrices
D=jacobian(KE,dq);
D=jacobian(D,dq);
%D=simple(D); % computation done entry by entry later
%pretty(D);

for i=1:length(q)
    for j=i:length(q)
        D(i,j)=simple(D(i,j));
        D(j,i)=D(i,j);
        disp(['D(',num2str(i),',',num2str(j),')= ',char(D(i,j))])
    end
end

%
C=0*D;
for k=1:length(q)
    for j=1:length(q)
        for i=1:length(q)
            C(k,j)=C(k,j)+(1/2)*(diff(D(k,j),q(i))+diff(D(k,i),q(j))-diff(D(i,j),q(k)))*dq(i);
        end
    end
end
%C=simple(C);  %moved to entry by entry

for i=1:length(q)
    for j=1:length(q)
        C(i,j)=simple(C(i,j));
        disp(['C(',num2str(i),',',num2str(j),')= ',char(C(i,j))])
    end
end



%% Potential energy
% PE = g*mT*pcmT(2) + g*m1*pcm1(2) + g*m2*pcm2(2) + g*m3*pcm3(2) + g*m4*pcm4(2) + g*m1*pcm1L(2) ...
%     + g*m2*pcm2L(2) + g*m3*pcm3L(2) + g*m4*pcm4L(2); PE=simple(PE);
PE = g*Mtotal*pcm(2);

Phi_springs=[]; Kdamping=[];

if springs
    % spring potential energy
    SE = (1/2)*K1*( q1-qgr1 )^2 + (1/2)*K2*(q2 - qgr2)^2;
    PE = PE+SE;
    Phi_springs=[Phi_springs; q1-qgr1; q2 - qgr2];
    Kdamping=[Kdamping,Kd1,Kd2];
end

if springsLeft
    % spring potential energy
    SE_Left = (1/2)*K1*( q1L-qgr1L )^2 + (1/2)*K2*(q2L - qgr2L)^2;
    PE = PE+SE_Left;
    Phi_springs=[Phi_springs; q1L-qgr1L; q2L - qgr2L];
    Kdamping=[Kdamping,Kd1,Kd2];
end

disp('PE computed')

%% Compute G
G=jacobian(PE,q).';
G=simple(G);

for i=1:length(q)
    disp(['G(',num2str(i),')= ',char(G(i))])
end

% Actuation
Phi=[qm1;qm2;qm1L;qm2L];
B=jacobian(Phi,q);
B=B.';

%%% Harmonic Drive Friction
%% Actuation
Phi_HarmonicDrive=[qgr1;qgr2;qgr1L;qgr2L];
B_HarmonicDrive=jacobian(Phi_HarmonicDrive,q);
B_HarmonicDrive=B_HarmonicDrive.';

%% Spring Damping
if length(Phi_springs) > 0 % Will not be the case because Phi_springs was not set in potential energy above.
    JacPhi_springs=jacobian(Phi_springs,q);
    B_springs=JacPhi_springs.';
    Kdamping=diag(Kdamping);
    DampingSpringTorque=B_springs*Kdamping*JacPhi_springs*dq;
    DampingSpringTorque=simple(DampingSpringTorque)
else
    DampingSpringTorque=zeros(length(q),1)*Kd1;
end


%% Used in the impact model and flight model

JacobianLeftFoot=jacobian(p4L,q);
EL=JacobianLeftFoot.';
E=JacobianLeftFoot;

ELq = simplify(jacobian(EL.'*dq,q)*dq);


JacobianRightFoot=jacobian(p4,q);
ER=JacobianRightFoot.';

ERq = simplify(jacobian(ER.'*dq,q)*dq);

save Mat\WorkTemp
%save test.mat

%% Write Files
switch lower(which_model)

    case {'dynamic','dynamicreduced'}

        Work_name = 'Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_';
        %Work_name2=[Work_name,datestr(now,7),datestr(now,3),datestr(now,10)];
        Work_name2=[Work_name,which_model,datestr(now,7)];
        eval(['save  ',Work_name2])

        fcn_name = 'LagrangeModelAtrias2D';
        generate_model

        PointsVector=[pT pHip p1 p2 p3 p4 p1L p2L p3L p4L pcm pcmT pcm1 pcm2 pcm3 pcm4 pcm1L pcm2L pcm3L pcm4L]; % Can add more points as well
        StringPointsVector='pT pHip p1 p2 p3 p4 p1L p2L p3L p4L pcm pcmT pcm1 pcm2 pcm3 pcm4 pcm1L pcm2L pcm3L pcm4L'; % Make sure to add them here as well

        fcn_name = 'PointsAtrias2D';
        generate_points

        fcn_name = 'PointsAtrias2DWorldFrame';
        generate_points_WorldFrame

        vcm=jacobian(pcm,q)*dq;
        J_cm=jacobian(pcm,q);
        dJ_cm=jacobian(J_cm*dq,q);

        VelAccelVector=[vHip vcm J_cm dJ_cm];
        StringVelAccelVector='vHip vcm J_cm dJ_cm';

        PrimaryVelocities=[vHip vcm];
        StringPrimaryVelocities='vHip vcm';

        AccelJacobians=[J_cm dJ_cm];
        StringAccelJacobians='J_cm dJ_cm';

        fcn_name = 'VelAccelAtrias2D';
        generate_velocties_accelerations


        Energies=[PE KE KET KE1 KE2 KE3 KE4 KEm1 KEm2 KE1L KE2L KE3L KE4L KEm1L KEm2L];
        StringEnergies='PE KE KET KE1 KE2 KE3 KE4 KEm1 KEm2 KE1L KE2L KE3L KE4L KEm1L KEm2L';


        fcn_name = 'EnergiesAtrias2D';
        generate_energies

        Work_name = 'Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_';
        %Work_name2=[Work_name,datestr(now,7),datestr(now,3),datestr(now,10)];
        Work_name2=[Work_name,which_model,datestr(now,7)];
        eval(['save  ',Work_name2])
    case {'impact'}

        Work_name = 'Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_';
        %Work_name2=[Work_name,datestr(now,7),datestr(now,3),datestr(now,10)];
        Work_name2=[Work_name,which_model,datestr(now,30)];
        eval(['save  ',Work_name2])

        fcn_name = 'ImpactModelAtrias2D';
        generate_model_impact

    case {'impactreduced'}  % No springs in the impact model

        Work_name = 'Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_';
        %Work_name2=[Work_name,datestr(now,7),datestr(now,3),datestr(now,10
        %)];
        Work_name2=[Work_name,which_model,datestr(now,30)];
        eval(['save  ',Work_name2])

        fcn_name = 'ImpactModelAtrias2D_NoSPrings';
        generate_model_impact

    case {'flight'}

        Work_name = 'Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_';
        Work_name2=[Work_name,which_model,datestr(now,30)];
        eval(['save  ',Work_name2])

        fcn_name = 'LagrangeModelAtriasFlight2D';
        generate_model_flight
        
        fcn_name = 'LagrangeModelAtriasConstraint2D';
        generate_model_constraint

        PointsVector=[pT pHip p1 p2 p3 p4 p1L p2L p3L p4L pcm pcmT pcm1 pcm2 pcm3 pcm4 pcm1L pcm2L pcm3L pcm4L];
        StringPointsVector='pT pHip p1 p2 p3 p4 p1L p2L p3L p4L pcm pcmT pcm1 pcm2 pcm3 pcm4 pcm1L pcm2L pcm3L pcm4L';

        fcn_name = 'PointsAtrias2D';
        generate_points

        %         fcn_name = 'PointsAtrias2DWorldFrame';
        %         generate_points_WorldFrame
        %
        vcm=jacobian(pcm,q)*dq;
        J_cm=jacobian(pcm,q);
        dJ_cm=jacobian(J_cm*dq,q);

        VelAccelVector=[vcm J_cm dJ_cm];
        StringVelAccelVector='vcm J_cm dJ_cm';

        %         PrimaryVelocities=[vHip vcm];
        %         StringPrimaryVelocities='vHip vcm';

        AccelJacobians=[J_cm dJ_cm];
        StringAccelJacobians='J_cm dJ_cm';

        fcn_name = 'VelAccelAtrias2D';
        generate_velocties_accelerations
        %
        %
        %         Energies=[PE KE KET KE1 KE2 KE3 KE4 KEm1 KEm2 KE1L KE2L KE3L KE4L KEm1L KEm2L];
        %         StringEnergies='PE KE KET KE1 KE2 KE3 KE4 KEm1 KEm2 KE1L KE2L KE3L KE4L KEm1L KEm2L';
        %

        %         fcn_name = 'EnergiesAtrias2D';
        %         generate_energies
        %
        Work_name = 'Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_';
        %Work_name2=[Work_name,datestr(now,7),datestr(now,3),datestr(now,10)];
        Work_name2=[Work_name,which_model,datestr(now,30)];
        eval(['save  ',Work_name2])

    case {'dynamic_leftstance'}

        Work_name = 'Mat\Work_Symbolic_2D_ATRIAS_Lagrange_JWG_';
        %Work_name2=[Work_name,datestr(now,7),datestr(now,3),datestr(now,10)];
        Work_name2=[Work_name,which_model,datestr(now,30)];
        eval(['save  ',Work_name2])

        fcn_name = 'LagrangeModelAtrias2D_Left';
        generate_model

    otherwise
        disp('ERROR ON MODEL CHOICE')
end

