function [vcm,J_cm,dJ_cm] =  VelAccel2D(q,dq)
%%%%%%  VelAccelAtrias2D.m
%%%%  26-May-2015 21:58:41
%%%%
%%%% Authors(s): Grizzle
%%%%
%%%%
[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ...
         ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT ...
         JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 ...
         Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;
%%%%
%%%%[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;
%%%%
%%%%
yH=q(1);  dyH=dq(1);
zH=q(2);  dzH=dq(2);
qT=q(3);  dqT=dq(3);
q1=q(4);  dq1=dq(4);
q2=q(5);  dq2=dq(5);
q1L=q(6);  dq1L=dq(6);
q2L=q(7);  dq2L=dq(7);
%%%%
%%%%
vcm=zeros(2,1)*q(1);
vcm(1,1)=dyH - (dqT*(m1*(ellzcm1*cos(q1 + qT) + ellycm1*...
         sin(q1 + qT)) + m2*(ellzcm2*cos(q2 + qT) + ellycm2*...
         sin(q2 + qT)) + m1*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + m2*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + m3*(L1*cos(q1 + qT) + ellzcm3*...
         cos(q2 + qT) + ellycm3*sin(q2 + qT)) + m4*(L2*...
         cos(q2 + qT) + ellzcm4*cos(q1 + qT) + ellycm4*sin(q1 + qT)) + m3*...
         (L1*cos(q1L + qT) + ellzcm3*cos(q2L + qT) + ellycm3*...
         sin(q2L + qT)) + m4*(L2*cos(q2L + qT) + ellzcm4*...
         cos(q1L + qT) + ellycm4*sin(q1L + qT)) + mT*(ellzcmT*...
         cos(qT) + ellycmT*sin(qT))))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dq1*(m1*(ellzcm1*cos(q1 + qT) + ellycm1*...
         sin(q1 + qT)) + m4*(ellzcm4*cos(q1 + qT) + ellycm4*...
         sin(q1 + qT)) + L1*m3*cos(q1 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dq2*(m2*(ellzcm2*cos(q2 + qT) + ellycm2*...
         sin(q2 + qT)) + m3*(ellzcm3*cos(q2 + qT) + ellycm3*...
         sin(q2 + qT)) + L2*m4*cos(q2 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dq1L*(m1*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + m4*(ellzcm4*cos(q1L + qT) + ellycm4*...
         sin(q1L + qT)) + L1*m3*cos(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dq2L*(m2*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + m3*(ellzcm3*cos(q2L + qT) + ellycm3*...
         sin(q2L + qT)) + L2*m4*cos(q2L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
vcm(2,1)=dzH + (dqT*(m1*(ellycm1*cos(q1 + qT) - ellzcm1*...
         sin(q1 + qT)) + m2*(ellycm2*cos(q2 + qT) - ellzcm2*...
         sin(q2 + qT)) + m1*(ellycm1*cos(q1L + qT) - ellzcm1*...
         sin(q1L + qT)) + m2*(ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + mT*(ellycmT*cos(qT) - ellzcmT*sin(qT)) - m3*(L1*...
         sin(q1 + qT) - ellycm3*cos(q2 + qT) + ellzcm3*sin(q2 + qT)) - m4*...
         (L2*sin(q2 + qT) - ellycm4*cos(q1 + qT) + ellzcm4*...
         sin(q1 + qT)) - m3*(L1*sin(q1L + qT) - ellycm3*...
         cos(q2L + qT) + ellzcm3*sin(q2L + qT)) - m4*(L2*...
         sin(q2L + qT) - ellycm4*cos(q1L + qT) + ellzcm4*...
         sin(q1L + qT))))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT) + (dq1*...
         (m1*(ellycm1*cos(q1 + qT) - ellzcm1*sin(q1 + qT)) + m4*(ellycm4*...
         cos(q1 + qT) - ellzcm4*sin(q1 + qT)) - L1*m3*sin(q1 + qT)))/(2*...
         m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT) + (dq2*(m2*(ellycm2*...
         cos(q2 + qT) - ellzcm2*sin(q2 + qT)) + m3*(ellycm3*...
         cos(q2 + qT) - ellzcm3*sin(q2 + qT)) - L2*m4*sin(q2 + qT)))/(2*...
         m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT) + (dq1L*(m1*(ellycm1*...
         cos(q1L + qT) - ellzcm1*sin(q1L + qT)) + m4*(ellycm4*...
         cos(q1L + qT) - ellzcm4*sin(q1L + qT)) - L1*m3*...
         sin(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT) + (dq2L*...
         (m2*(ellycm2*cos(q2L + qT) - ellzcm2*sin(q2L + qT)) + m3*...
         (ellycm3*cos(q2L + qT) - ellzcm3*sin(q2L + qT)) - L2*m4*...
         sin(q2L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT);
J_cm=zeros(2,7)*q(1);
J_cm(1,1)=1;
J_cm(1,3)=-(m1*(ellzcm1*cos(q1 + qT) + ellycm1*...
         sin(q1 + qT)) + m2*(ellzcm2*cos(q2 + qT) + ellycm2*...
         sin(q2 + qT)) + m1*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + m2*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + m3*(L1*cos(q1 + qT) + ellzcm3*...
         cos(q2 + qT) + ellycm3*sin(q2 + qT)) + m4*(L2*...
         cos(q2 + qT) + ellzcm4*cos(q1 + qT) + ellycm4*sin(q1 + qT)) + m3*...
         (L1*cos(q1L + qT) + ellzcm3*cos(q2L + qT) + ellycm3*...
         sin(q2L + qT)) + m4*(L2*cos(q2L + qT) + ellzcm4*...
         cos(q1L + qT) + ellycm4*sin(q1L + qT)) + mT*(ellzcmT*...
         cos(qT) + ellycmT*sin(qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
J_cm(1,4)=-(m1*(ellzcm1*cos(q1 + qT) + ellycm1*...
         sin(q1 + qT)) + m4*(ellzcm4*cos(q1 + qT) + ellycm4*...
         sin(q1 + qT)) + L1*m3*cos(q1 + qT))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
J_cm(1,5)=-(m2*(ellzcm2*cos(q2 + qT) + ellycm2*...
         sin(q2 + qT)) + m3*(ellzcm3*cos(q2 + qT) + ellycm3*...
         sin(q2 + qT)) + L2*m4*cos(q2 + qT))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
J_cm(1,6)=-(m1*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + m4*(ellzcm4*cos(q1L + qT) + ellycm4*...
         sin(q1L + qT)) + L1*m3*cos(q1L + qT))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
J_cm(1,7)=-(m2*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + m3*(ellzcm3*cos(q2L + qT) + ellycm3*...
         sin(q2L + qT)) + L2*m4*cos(q2L + qT))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
J_cm(2,2)=1;
J_cm(2,3)=(m1*(ellycm1*cos(q1 + qT) - ellzcm1*sin(q1 + qT)) + m2*...
         (ellycm2*cos(q2 + qT) - ellzcm2*sin(q2 + qT)) + m1*(ellycm1*...
         cos(q1L + qT) - ellzcm1*sin(q1L + qT)) + m2*(ellycm2*...
         cos(q2L + qT) - ellzcm2*sin(q2L + qT)) + mT*(ellycmT*...
         cos(qT) - ellzcmT*sin(qT)) - m3*(L1*sin(q1 + qT) - ellycm3*...
         cos(q2 + qT) + ellzcm3*sin(q2 + qT)) - m4*(L2*...
         sin(q2 + qT) - ellycm4*cos(q1 + qT) + ellzcm4*sin(q1 + qT)) - m3*...
         (L1*sin(q1L + qT) - ellycm3*cos(q2L + qT) + ellzcm3*...
         sin(q2L + qT)) - m4*(L2*sin(q2L + qT) - ellycm4*...
         cos(q1L + qT) + ellzcm4*sin(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
J_cm(2,4)=(m1*(ellycm1*cos(q1 + qT) - ellzcm1*sin(q1 + qT)) + m4*...
         (ellycm4*cos(q1 + qT) - ellzcm4*sin(q1 + qT)) - L1*m3*...
         sin(q1 + qT))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT);
J_cm(2,5)=(m2*(ellycm2*cos(q2 + qT) - ellzcm2*sin(q2 + qT)) + m3*...
         (ellycm3*cos(q2 + qT) - ellzcm3*sin(q2 + qT)) - L2*m4*...
         sin(q2 + qT))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT);
J_cm(2,6)=(m1*(ellycm1*cos(q1L + qT) - ellzcm1*...
         sin(q1L + qT)) + m4*(ellycm4*cos(q1L + qT) - ellzcm4*...
         sin(q1L + qT)) - L1*m3*sin(q1L + qT))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
J_cm(2,7)=(m2*(ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + m3*(ellycm3*cos(q2L + qT) - ellzcm3*...
         sin(q2L + qT)) - L2*m4*sin(q2L + qT))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm=zeros(2,7)*q(1);
dJ_cm(1,3)=- (dqT*(m1*(ellycm1*cos(q1 + qT) - ellzcm1*...
         sin(q1 + qT)) + m2*(ellycm2*cos(q2 + qT) - ellzcm2*...
         sin(q2 + qT)) + m1*(ellycm1*cos(q1L + qT) - ellzcm1*...
         sin(q1L + qT)) + m2*(ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + mT*(ellycmT*cos(qT) - ellzcmT*sin(qT)) - m3*(L1*...
         sin(q1 + qT) - ellycm3*cos(q2 + qT) + ellzcm3*sin(q2 + qT)) - m4*...
         (L2*sin(q2 + qT) - ellycm4*cos(q1 + qT) + ellzcm4*...
         sin(q1 + qT)) - m3*(L1*sin(q1L + qT) - ellycm3*...
         cos(q2L + qT) + ellzcm3*sin(q2L + qT)) - m4*(L2*...
         sin(q2L + qT) - ellycm4*cos(q1L + qT) + ellzcm4*...
         sin(q1L + qT))))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT) - (dq1*...
         (m1*(ellycm1*cos(q1 + qT) - ellzcm1*sin(q1 + qT)) + m4*(ellycm4*...
         cos(q1 + qT) - ellzcm4*sin(q1 + qT)) - L1*m3*sin(q1 + qT)))/(2*...
         m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT) - (dq2*(m2*(ellycm2*...
         cos(q2 + qT) - ellzcm2*sin(q2 + qT)) + m3*(ellycm3*...
         cos(q2 + qT) - ellzcm3*sin(q2 + qT)) - L2*m4*sin(q2 + qT)))/(2*...
         m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT) - (dq1L*(m1*(ellycm1*...
         cos(q1L + qT) - ellzcm1*sin(q1L + qT)) + m4*(ellycm4*...
         cos(q1L + qT) - ellzcm4*sin(q1L + qT)) - L1*m3*...
         sin(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT) - (dq2L*...
         (m2*(ellycm2*cos(q2L + qT) - ellzcm2*sin(q2L + qT)) + m3*...
         (ellycm3*cos(q2L + qT) - ellzcm3*sin(q2L + qT)) - L2*m4*...
         sin(q2L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*m4 + mH + mT);
dJ_cm(1,4)=- (dq1*(m1*(ellycm1*cos(q1 + qT) - ellzcm1*...
         sin(q1 + qT)) + m4*(ellycm4*cos(q1 + qT) - ellzcm4*...
         sin(q1 + qT)) - L1*m3*sin(q1 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dqT*(m1*(ellycm1*cos(q1 + qT) - ellzcm1*...
         sin(q1 + qT)) + m4*(ellycm4*cos(q1 + qT) - ellzcm4*...
         sin(q1 + qT)) - L1*m3*sin(q1 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm(1,5)=- (dq2*(m2*(ellycm2*cos(q2 + qT) - ellzcm2*...
         sin(q2 + qT)) + m3*(ellycm3*cos(q2 + qT) - ellzcm3*...
         sin(q2 + qT)) - L2*m4*sin(q2 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dqT*(m2*(ellycm2*cos(q2 + qT) - ellzcm2*...
         sin(q2 + qT)) + m3*(ellycm3*cos(q2 + qT) - ellzcm3*...
         sin(q2 + qT)) - L2*m4*sin(q2 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm(1,6)=- (dq1L*(m1*(ellycm1*cos(q1L + qT) - ellzcm1*...
         sin(q1L + qT)) + m4*(ellycm4*cos(q1L + qT) - ellzcm4*...
         sin(q1L + qT)) - L1*m3*sin(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dqT*(m1*(ellycm1*cos(q1L + qT) - ellzcm1*...
         sin(q1L + qT)) + m4*(ellycm4*cos(q1L + qT) - ellzcm4*...
         sin(q1L + qT)) - L1*m3*sin(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm(1,7)=- (dq2L*(m2*(ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + m3*(ellycm3*cos(q2L + qT) - ellzcm3*...
         sin(q2L + qT)) - L2*m4*sin(q2L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dqT*(m2*(ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + m3*(ellycm3*cos(q2L + qT) - ellzcm3*...
         sin(q2L + qT)) - L2*m4*sin(q2L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm(2,3)=- (dqT*(m1*(ellzcm1*cos(q1 + qT) + ellycm1*...
         sin(q1 + qT)) + m2*(ellzcm2*cos(q2 + qT) + ellycm2*...
         sin(q2 + qT)) + m1*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + m2*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + m3*(L1*cos(q1 + qT) + ellzcm3*...
         cos(q2 + qT) + ellycm3*sin(q2 + qT)) + m4*(L2*...
         cos(q2 + qT) + ellzcm4*cos(q1 + qT) + ellycm4*sin(q1 + qT)) + m3*...
         (L1*cos(q1L + qT) + ellzcm3*cos(q2L + qT) + ellycm3*...
         sin(q2L + qT)) + m4*(L2*cos(q2L + qT) + ellzcm4*...
         cos(q1L + qT) + ellycm4*sin(q1L + qT)) + mT*(ellzcmT*...
         cos(qT) + ellycmT*sin(qT))))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dq1*(m1*(ellzcm1*cos(q1 + qT) + ellycm1*...
         sin(q1 + qT)) + m4*(ellzcm4*cos(q1 + qT) + ellycm4*...
         sin(q1 + qT)) + L1*m3*cos(q1 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dq2*(m2*(ellzcm2*cos(q2 + qT) + ellycm2*...
         sin(q2 + qT)) + m3*(ellzcm3*cos(q2 + qT) + ellycm3*...
         sin(q2 + qT)) + L2*m4*cos(q2 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dq1L*(m1*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + m4*(ellzcm4*cos(q1L + qT) + ellycm4*...
         sin(q1L + qT)) + L1*m3*cos(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dq2L*(m2*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + m3*(ellzcm3*cos(q2L + qT) + ellycm3*...
         sin(q2L + qT)) + L2*m4*cos(q2L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm(2,4)=- (dq1*(m1*(ellzcm1*cos(q1 + qT) + ellycm1*...
         sin(q1 + qT)) + m4*(ellzcm4*cos(q1 + qT) + ellycm4*...
         sin(q1 + qT)) + L1*m3*cos(q1 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dqT*(m1*(ellzcm1*cos(q1 + qT) + ellycm1*...
         sin(q1 + qT)) + m4*(ellzcm4*cos(q1 + qT) + ellycm4*...
         sin(q1 + qT)) + L1*m3*cos(q1 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm(2,5)=- (dq2*(m2*(ellzcm2*cos(q2 + qT) + ellycm2*...
         sin(q2 + qT)) + m3*(ellzcm3*cos(q2 + qT) + ellycm3*...
         sin(q2 + qT)) + L2*m4*cos(q2 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dqT*(m2*(ellzcm2*cos(q2 + qT) + ellycm2*...
         sin(q2 + qT)) + m3*(ellzcm3*cos(q2 + qT) + ellycm3*...
         sin(q2 + qT)) + L2*m4*cos(q2 + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm(2,6)=- (dq1L*(m1*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + m4*(ellzcm4*cos(q1L + qT) + ellycm4*...
         sin(q1L + qT)) + L1*m3*cos(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dqT*(m1*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + m4*(ellzcm4*cos(q1L + qT) + ellycm4*...
         sin(q1L + qT)) + L1*m3*cos(q1L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
dJ_cm(2,7)=- (dq2L*(m2*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + m3*(ellzcm3*cos(q2L + qT) + ellycm3*...
         sin(q2L + qT)) + L2*m4*cos(q2L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT) - (dqT*(m2*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + m3*(ellzcm3*cos(q2L + qT) + ellycm3*...
         sin(q2L + qT)) + L2*m4*cos(q2L + qT)))/(2*m1 + 2*m2 + 2*m3 + 2*...
         m4 + mH + mT);
%%%%
%%%%
return