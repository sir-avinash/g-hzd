function [p_knee,E_knee,Eq_knee]= swing_knee_pos(q,dq)
%%%%%%  LagrangeModelAtriasConstraint2D.m
%%%%  01-Feb-2015 21:40:51
%%%%
%%%% Authors(s): Grizzle
%%%%
%%%%
%%%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)
%%%%                 EL = jacobian(p4L,q)'; ELq = simplify(jacobian(EL'*dq,q)*dq); EL*xddot + ELq = 0; 
%%%%
%%%%
[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ...
         ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT ...
         JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 ...
         Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v06;
%%%%
%%%%[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;
%%%%
%%%%
%% Quan Note
% to compute swing knee pos and derivative; replace L4=> 0 in computation
% of p4L,EL,ELq
%%

yH=q(1);  dyH=dq(1);
zH=q(2);  dzH=dq(2);
qT=q(3);  dqT=dq(3);
q1=q(4);  dq1=dq(4);
q2=q(5);  dq2=dq(5);
q1L=q(6);  dq1L=dq(6);
q2L=q(7);  dq2L=dq(7);
EL=zeros(7,2)*q(1);
EL(1,1)=1;
EL(2,2)=1;
EL(3,1)=- L2*cos(q2L + qT) - 0*L4*cos(q1L + qT);
EL(3,2)=- L2*sin(q2L + qT) - 0*L4*sin(q1L + qT);
EL(6,1)=-0*L4*cos(q1L + qT);
EL(6,2)=-0*L4*sin(q1L + qT);
EL(7,1)=-L2*cos(q2L + qT);
EL(7,2)=-L2*sin(q2L + qT);
%%%%
%%%%
ER=zeros(7,2)*q(1);
ER(1,1)=1;
ER(2,2)=1;
ER(3,1)=- L2*cos(q2 + qT) - L4*cos(q1 + qT);
ER(3,2)=- L2*sin(q2 + qT) - L4*sin(q1 + qT);
ER(4,1)=-L4*cos(q1 + qT);
ER(4,2)=-L4*sin(q1 + qT);
ER(5,1)=-L2*cos(q2 + qT);
ER(5,2)=-L2*sin(q2 + qT);
%%%%
%%%%
ELq=zeros(2,1)*q(1);
ELq(1,1)=L2*dq2L^2*sin(q2L + qT) + 0*L4*dq1L^2*sin(q1L + qT) + L2*...
         dqT^2*sin(q2L + qT) + 0*L4*dqT^2*sin(q1L + qT) + 2*L2*dq2L*dqT*...
         sin(q2L + qT) + 0*2*L4*dq1L*dqT*sin(q1L + qT);
ELq(2,1)=- L2*dq2L^2*cos(q2L + qT) - 0*L4*dq1L^2*...
         cos(q1L + qT) - L2*dqT^2*cos(q2L + qT) - 0*L4*dqT^2*...
         cos(q1L + qT) - 2*L2*dq2L*dqT*cos(q2L + qT) - 0*2*L4*dq1L*dqT*...
         cos(q1L + qT);
%%%%
%%%%
ERq=zeros(2,1)*q(1);
ERq(1,1)=L2*dq2^2*sin(q2 + qT) + L4*dq1^2*sin(q1 + qT) + L2*...
         dqT^2*sin(q2 + qT) + L4*dqT^2*sin(q1 + qT) + 2*L2*dq2*dqT*...
         sin(q2 + qT) + 2*L4*dq1*dqT*sin(q1 + qT);
ERq(2,1)=- L2*dq2^2*cos(q2 + qT) - L4*dq1^2*cos(q1 + qT) - L2*...
         dqT^2*cos(q2 + qT) - L4*dqT^2*cos(q1 + qT) - 2*L2*dq2*dqT*...
         cos(q2 + qT) - 2*L4*dq1*dqT*cos(q1 + qT);
%%%%
%%%%
p4=zeros(2,1)*q(1);
p4(1,1)=yH - L2*sin(q2 + qT) - L4*sin(q1 + qT);
p4(2,1)=zH + L2*cos(q2 + qT) + L4*cos(q1 + qT);
%%%%
%%%%
p4L=zeros(2,1)*q(1);
p4L(1,1)=yH - L2*sin(q2L + qT) - 0*L4*sin(q1L + qT);
p4L(2,1)=zH + L2*cos(q2L + qT) + 0*L4*cos(q1L + qT);
p_knee=p4L-p4;
E_knee=EL-ER;
Eq_knee=ELq-ERq;
return