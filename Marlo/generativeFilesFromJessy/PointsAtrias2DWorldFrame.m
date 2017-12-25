function [pT pHip p1 p2 p3 p4 p1L p2L p3L p4L pcm pcmT pcm1 pcm2 pcm3 pcm4 pcm1L pcm2L pcm3L pcm4L] =  PointsAtrias2DWorldFrame(q,pFootStance)
%%%%%%  PointsAtrias2DWorldFrame.m
%%%%  23-Nov-2015 16:52:25
%%%%
%%%% Authors(s): Griffin (Grizzle original)
%%%%
if nargin <2, pFootStance=[0;0]; end
%%%%
[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ...
         ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT ...
         JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 ...
         Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;
%%%%
%%%%[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;
%%%%
%%%%
qT=q(1);  
q1=q(2);  
q2=q(3);  
q1L=q(4);  
q2L=q(5);  
%%%%
%%%%
pT=[pFootStance(1) + L2*sin(q2 + qT) + L4*sin(q1 + qT) - LT*...
         sin(qT);pFootStance(2) + LT*cos(qT) - L4*cos(q1 + qT) - L2*...
         cos(q2 + qT)];
%
pHip=[pFootStance(1) + L2*sin(q2 + qT) + L4*sin(q1 + qT);...
         pFootStance(2) + - L2*cos(q2 + qT) - L4*cos(q1 + qT)];
%
p1=[pFootStance(1) + L2*sin(q2 + qT) - L1*sin(q1 + qT) + L4*...
         sin(q1 + qT);pFootStance(2) + L1*cos(q1 + qT) - L2*...
         cos(q2 + qT) - L4*cos(q1 + qT)];
%
p2=[pFootStance(1) + L4*sin(q1 + qT);pFootStance(2) + -L4*...
         cos(q1 + qT)];
%
p3=[pFootStance(1) + L2*sin(q2 + qT) - L1*sin(q1 + qT) - L3*...
         sin(q2 + qT) + L4*sin(q1 + qT);pFootStance(2) + L1*...
         cos(q1 + qT) - L2*cos(q2 + qT) + L3*cos(q2 + qT) - L4*...
         cos(q1 + qT)];
%
p4=[pFootStance(1) + 0;pFootStance(2) + 0];
%
p1L=[pFootStance(1) + L2*sin(q2 + qT) + L4*sin(q1 + qT) - L1*...
         sin(q1L + qT);pFootStance(2) + L1*cos(q1L + qT) - L4*...
         cos(q1 + qT) - L2*cos(q2 + qT)];
%
p2L=[pFootStance(1) + L2*sin(q2 + qT) + L4*sin(q1 + qT) - L2*...
         sin(q2L + qT);pFootStance(2) + L2*cos(q2L + qT) - L4*...
         cos(q1 + qT) - L2*cos(q2 + qT)];
%
p3L=[pFootStance(1) + L2*sin(q2 + qT) + L4*sin(q1 + qT) - L1*...
         sin(q1L + qT) - L3*sin(q2L + qT);pFootStance(2) + L1*...
         cos(q1L + qT) - L4*cos(q1 + qT) - L2*cos(q2 + qT) + L3*...
         cos(q2L + qT)];
%
p4L=[pFootStance(1) + L2*sin(q2 + qT) + L4*sin(q1 + qT) - L2*...
         sin(q2L + qT) - L4*sin(q1L + qT);pFootStance(2) + L2*...
         cos(q2L + qT) - L4*cos(q1 + qT) - L2*cos(q2 + qT) + L4*...
         cos(q1L + qT)];
%
pcm=[pFootStance(1) + (ellycmT*mT*cos(qT) - ellzcmT*mT*...
         sin(qT) - L1*m3*sin(q1 + qT) + 2*L2*m1*sin(q2 + qT) + 2*L2*m2*...
         sin(q2 + qT) + 2*L4*m1*sin(q1 + qT) + 2*L2*m3*sin(q2 + qT) + 2*...
         L4*m2*sin(q1 + qT) + L2*m4*sin(q2 + qT) + 2*L4*m3*...
         sin(q1 + qT) + 2*L4*m4*sin(q1 + qT) - L1*m3*sin(q1L + qT) - L2*...
         m4*sin(q2L + qT) + L2*mH*sin(q2 + qT) + L4*mH*sin(q1 + qT) + L2*...
         mT*sin(q2 + qT) + L4*mT*sin(q1 + qT) + ellycm1*m1*...
         cos(q1 + qT) + ellycm2*m2*cos(q2 + qT) + ellycm3*m3*...
         cos(q2 + qT) + ellycm4*m4*cos(q1 + qT) + ellycm1*m1*...
         cos(q1L + qT) + ellycm2*m2*cos(q2L + qT) + ellycm3*m3*...
         cos(q2L + qT) + ellycm4*m4*cos(q1L + qT) - ellzcm1*m1*...
         sin(q1 + qT) - ellzcm2*m2*sin(q2 + qT) - ellzcm3*m3*...
         sin(q2 + qT) - ellzcm4*m4*sin(q1 + qT) - ellzcm1*m1*...
         sin(q1L + qT) - ellzcm2*m2*sin(q2L + qT) - ellzcm3*m3*...
         sin(q2L + qT) - ellzcm4*m4*sin(q1L + qT))/(2*m1 + 2*m2 + 2*...
         m3 + 2*m4 + mH + mT);pFootStance(2) + (ellzcmT*mT*...
         cos(qT) + ellycmT*mT*sin(qT) + L1*m3*cos(q1 + qT) - 2*L2*m1*...
         cos(q2 + qT) - 2*L2*m2*cos(q2 + qT) - 2*L4*m1*cos(q1 + qT) - 2*...
         L2*m3*cos(q2 + qT) - 2*L4*m2*cos(q1 + qT) - L2*m4*...
         cos(q2 + qT) - 2*L4*m3*cos(q1 + qT) - 2*L4*m4*cos(q1 + qT) + L1*...
         m3*cos(q1L + qT) + L2*m4*cos(q2L + qT) - L2*mH*cos(q2 + qT) - L4*...
         mH*cos(q1 + qT) - L2*mT*cos(q2 + qT) - L4*mT*...
         cos(q1 + qT) + ellzcm1*m1*cos(q1 + qT) + ellzcm2*m2*...
         cos(q2 + qT) + ellzcm3*m3*cos(q2 + qT) + ellzcm4*m4*...
         cos(q1 + qT) + ellzcm1*m1*cos(q1L + qT) + ellzcm2*m2*...
         cos(q2L + qT) + ellzcm3*m3*cos(q2L + qT) + ellzcm4*m4*...
         cos(q1L + qT) + ellycm1*m1*sin(q1 + qT) + ellycm2*m2*...
         sin(q2 + qT) + ellycm3*m3*sin(q2 + qT) + ellycm4*m4*...
         sin(q1 + qT) + ellycm1*m1*sin(q1L + qT) + ellycm2*m2*...
         sin(q2L + qT) + ellycm3*m3*sin(q2L + qT) + ellycm4*m4*...
         sin(q1L + qT))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT)];
%
pcmT=[pFootStance(1) + L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycmT*cos(qT) - ellzcmT*sin(qT);...
         pFootStance(2) + ellzcmT*cos(qT) - L4*cos(q1 + qT) - L2*...
         cos(q2 + qT) + ellycmT*sin(qT)];
%
pcm1=[pFootStance(1) + L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm1*cos(q1 + qT) - ellzcm1*sin(q1 + qT);...
         pFootStance(2) + ellzcm1*cos(q1 + qT) - L4*cos(q1 + qT) - L2*...
         cos(q2 + qT) + ellycm1*sin(q1 + qT)];
%
pcm2=[pFootStance(1) + L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm2*cos(q2 + qT) - ellzcm2*sin(q2 + qT);...
         pFootStance(2) + ellzcm2*cos(q2 + qT) - L4*cos(q1 + qT) - L2*...
         cos(q2 + qT) + ellycm2*sin(q2 + qT)];
%
pcm3=[pFootStance(1) + L2*sin(q2 + qT) - L1*sin(q1 + qT) + L4*...
         sin(q1 + qT) + ellycm3*cos(q2 + qT) - ellzcm3*sin(q2 + qT);...
         pFootStance(2) + L1*cos(q1 + qT) - L2*cos(q2 + qT) - L4*...
         cos(q1 + qT) + ellzcm3*cos(q2 + qT) + ellycm3*sin(q2 + qT)];
%
pcm4=[pFootStance(1) + L4*sin(q1 + qT) + ellycm4*...
         cos(q1 + qT) - ellzcm4*sin(q1 + qT);pFootStance(2) + ellzcm4*...
         cos(q1 + qT) - L4*cos(q1 + qT) + ellycm4*sin(q1 + qT)];
%
pcm1L=[pFootStance(1) + L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm1*cos(q1L + qT) - ellzcm1*sin(q1L + qT);...
         pFootStance(2) + ellzcm1*cos(q1L + qT) - L4*cos(q1 + qT) - L2*...
         cos(q2 + qT) + ellycm1*sin(q1L + qT)];
%
pcm2L=[pFootStance(1) + L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm2*cos(q2L + qT) - ellzcm2*sin(q2L + qT);...
         pFootStance(2) + ellzcm2*cos(q2L + qT) - L4*cos(q1 + qT) - L2*...
         cos(q2 + qT) + ellycm2*sin(q2L + qT)];
%
pcm3L=[pFootStance(1) + L2*sin(q2 + qT) + L4*sin(q1 + qT) - L1*...
         sin(q1L + qT) + ellycm3*cos(q2L + qT) - ellzcm3*sin(q2L + qT);...
         pFootStance(2) + L1*cos(q1L + qT) - L4*cos(q1 + qT) - L2*...
         cos(q2 + qT) + ellzcm3*cos(q2L + qT) + ellycm3*sin(q2L + qT)];
%
pcm4L=[pFootStance(1) + L2*sin(q2 + qT) + L4*sin(q1 + qT) - L2*...
         sin(q2L + qT) + ellycm4*cos(q1L + qT) - ellzcm4*sin(q1L + qT);...
         pFootStance(2) + L2*cos(q2L + qT) - L4*cos(q1 + qT) - L2*...
         cos(q2 + qT) + ellzcm4*cos(q1L + qT) + ellycm4*sin(q1L + qT)];
%
%%%%
%%%%
return