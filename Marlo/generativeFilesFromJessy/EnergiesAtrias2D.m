function [PE KE KET KE1 KE2 KE3 KE4 KEm1 KEm2 KE1L KE2L KE3L KE4L KEm1L KEm2L] =  EnergiesAtrias2D(q,dq)
%%%%%%  EnergiesAtrias2D.m
%%%%  23-Nov-2015 16:52:26
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
qT=q(1);  dqT=dq(1);
q1=q(2);  dq1=dq(2);
q2=q(3);  dq2=dq(3);
q1L=q(4);  dq1L=dq(4);
q2L=q(5);  dq2L=dq(5);
%%%%
%%%%
PE=zeros(1,1);
PE(1,1)=g*(ellzcmT*mT*cos(qT) + ellycmT*mT*sin(qT) + L1*m3*...
         cos(q1 + qT) - 2*L2*m1*cos(q2 + qT) - 2*L2*m2*cos(q2 + qT) - 2*...
         L4*m1*cos(q1 + qT) - 2*L2*m3*cos(q2 + qT) - 2*L4*m2*...
         cos(q1 + qT) - L2*m4*cos(q2 + qT) - 2*L4*m3*cos(q1 + qT) - 2*L4*...
         m4*cos(q1 + qT) + L1*m3*cos(q1L + qT) + L2*m4*cos(q2L + qT) - L2*...
         mH*cos(q2 + qT) - L4*mH*cos(q1 + qT) - L2*mT*cos(q2 + qT) - L4*...
         mT*cos(q1 + qT) + ellzcm1*m1*cos(q1 + qT) + ellzcm2*m2*...
         cos(q2 + qT) + ellzcm3*m3*cos(q2 + qT) + ellzcm4*m4*...
         cos(q1 + qT) + ellzcm1*m1*cos(q1L + qT) + ellzcm2*m2*...
         cos(q2L + qT) + ellzcm3*m3*cos(q2L + qT) + ellzcm4*m4*...
         cos(q1L + qT) + ellycm1*m1*sin(q1 + qT) + ellycm2*m2*...
         sin(q2 + qT) + ellycm3*m3*sin(q2 + qT) + ellycm4*m4*...
         sin(q1 + qT) + ellycm1*m1*sin(q1L + qT) + ellycm2*m2*...
         sin(q2L + qT) + ellycm3*m3*sin(q2L + qT) + ellycm4*m4*...
         sin(q1L + qT));
KE=zeros(1,1);
KE(1,1)=(m3*(dqT*(L2*sin(q2 + qT) - L1*sin(q1 + qT) + L4*...
         sin(q1 + qT) + ellycm3*cos(q2 + qT) - ellzcm3*...
         sin(q2 + qT)) + dq2*(L2*sin(q2 + qT) + ellycm3*...
         cos(q2 + qT) - ellzcm3*sin(q2 + qT)) - dq1*(L1*sin(q1 + qT) - L4*...
         sin(q1 + qT)))^2)/2 + (m3*(L1*dq1L*cos(q1L + qT) - L4*dq1*...
         cos(q1 + qT) - L2*dq2*cos(q2 + qT) - L2*dqT*cos(q2 + qT) - L4*...
         dqT*cos(q1 + qT) + L1*dqT*cos(q1L + qT) + dq2L*ellzcm3*...
         cos(q2L + qT) + dqT*ellzcm3*cos(q2L + qT) + dq2L*ellycm3*...
         sin(q2L + qT) + dqT*ellycm3*sin(q2L + qT))^2)/2 + (m4*(L2*dq2L*...
         cos(q2L + qT) - L4*dq1*cos(q1 + qT) - L2*dq2*cos(q2 + qT) - L2*...
         dqT*cos(q2 + qT) - L4*dqT*cos(q1 + qT) + L2*dqT*...
         cos(q2L + qT) + dq1L*ellzcm4*cos(q1L + qT) + dqT*ellzcm4*...
         cos(q1L + qT) + dq1L*ellycm4*sin(q1L + qT) + dqT*ellycm4*...
         sin(q1L + qT))^2)/2 + (Jcm1*(dq1 + dqT)^2)/2 + (Jcm2*...
         (dq2 + dqT)^2)/2 + (Jcm3*(dq2 + dqT)^2)/2 + (Jcm1*...
         (dq1L + dqT)^2)/2 + (Jcm2*(dq2L + dqT)^2)/2 + (Jcm3*...
         (dq2L + dqT)^2)/2 + (Jcm4*(dq1L + dqT)^2)/2 + (Jgear1*...
         (dq1 + dqT)^2)/2 + (Jgear2*(dq2 + dqT)^2)/2 + (Jgear1*...
         (dq1L + dqT)^2)/2 + (Jgear2*(dq2L + dqT)^2)/2 + (mT*(dqT*(L2*...
         sin(q2 + qT) + L4*sin(q1 + qT) + ellycmT*cos(qT) - ellzcmT*...
         sin(qT)) + L2*dq2*sin(q2 + qT) + L4*dq1*sin(q1 + qT))^2)/2 + (m1*...
         (dqT*(L2*cos(q2 + qT) + L4*cos(q1 + qT) - ellzcm1*...
         cos(q1 + qT) - ellycm1*sin(q1 + qT)) - dq1*(ellzcm1*...
         cos(q1 + qT) - L4*cos(q1 + qT) + ellycm1*sin(q1 + qT)) + L2*dq2*...
         cos(q2 + qT))^2)/2 + (m2*(dqT*(L2*cos(q2 + qT) + L4*...
         cos(q1 + qT) - ellzcm2*cos(q2 + qT) - ellycm2*...
         sin(q2 + qT)) - dq2*(ellzcm2*cos(q2 + qT) - L2*...
         cos(q2 + qT) + ellycm2*sin(q2 + qT)) + L4*dq1*...
         cos(q1 + qT))^2)/2 + (JcmH*dqT^2)/2 + (JcmT*dqT^2)/2 + (m1*(dq1*...
         (L4*sin(q1 + qT) + ellycm1*cos(q1 + qT) - ellzcm1*...
         sin(q1 + qT)) + dqT*(L2*sin(q2 + qT) + L4*sin(q1 + qT) + ellycm1*...
         cos(q1 + qT) - ellzcm1*sin(q1 + qT)) + L2*dq2*...
         sin(q2 + qT))^2)/2 + (m2*(dq2*(L2*sin(q2 + qT) + ellycm2*...
         cos(q2 + qT) - ellzcm2*sin(q2 + qT)) + dqT*(L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm2*cos(q2 + qT) - ellzcm2*sin(q2 + qT)) + L4*...
         dq1*sin(q1 + qT))^2)/2 + (m3*(L2*dq2*sin(q2 + qT) + L4*dq1*...
         sin(q1 + qT) - L1*dq1L*sin(q1L + qT) + L2*dqT*sin(q2 + qT) + L4*...
         dqT*sin(q1 + qT) - L1*dqT*sin(q1L + qT) + dq2L*ellycm3*...
         cos(q2L + qT) + dqT*ellycm3*cos(q2L + qT) - dq2L*ellzcm3*...
         sin(q2L + qT) - dqT*ellzcm3*sin(q2L + qT))^2)/2 + (m4*(L2*dq2*...
         sin(q2 + qT) + L4*dq1*sin(q1 + qT) - L2*dq2L*sin(q2L + qT) + L2*...
         dqT*sin(q2 + qT) + L4*dqT*sin(q1 + qT) - L2*dqT*...
         sin(q2L + qT) + dq1L*ellycm4*cos(q1L + qT) + dqT*ellycm4*...
         cos(q1L + qT) - dq1L*ellzcm4*sin(q1L + qT) - dqT*ellzcm4*...
         sin(q1L + qT))^2)/2 + (m3*(dq2*(ellzcm3*cos(q2 + qT) - L2*...
         cos(q2 + qT) + ellycm3*sin(q2 + qT)) + dq1*(L1*cos(q1 + qT) - L4*...
         cos(q1 + qT)) + dqT*(L1*cos(q1 + qT) - L2*cos(q2 + qT) - L4*...
         cos(q1 + qT) + ellzcm3*cos(q2 + qT) + ellycm3*...
         sin(q2 + qT)))^2)/2 + (m1*(dqT*(L2*cos(q2 + qT) + L4*...
         cos(q1 + qT) - ellzcm1*cos(q1L + qT) - ellycm1*...
         sin(q1L + qT)) - dq1L*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + L2*dq2*cos(q2 + qT) + L4*dq1*...
         cos(q1 + qT))^2)/2 + (m2*(dqT*(L2*cos(q2 + qT) + L4*...
         cos(q1 + qT) - ellzcm2*cos(q2L + qT) - ellycm2*...
         sin(q2L + qT)) - dq2L*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + L2*dq2*cos(q2 + qT) + L4*dq1*...
         cos(q1 + qT))^2)/2 + ((dq1 + dqT)^2*(Jcm4 + L4^2*m4 + ellycm4^2*...
         m4 + ellzcm4^2*m4 - 2*L4*ellzcm4*m4))/2 + (Jrotor1*(dqT + R1*...
         dq1)^2)/2 + (Jrotor2*(dqT + R2*dq2)^2)/2 + (Jrotor1*(dqT + R1*...
         dq1L)^2)/2 + (Jrotor2*(dqT + R2*dq2L)^2)/2 + (m1*(dq1L*(ellycm1*...
         cos(q1L + qT) - ellzcm1*sin(q1L + qT)) + dqT*(L2*...
         sin(q2 + qT) + L4*sin(q1 + qT) + ellycm1*cos(q1L + qT) - ellzcm1*...
         sin(q1L + qT)) + L2*dq2*sin(q2 + qT) + L4*dq1*...
         sin(q1 + qT))^2)/2 + (m2*(dq2L*(ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + dqT*(L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + L2*dq2*sin(q2 + qT) + L4*dq1*...
         sin(q1 + qT))^2)/2 + (mT*(dqT*(L2*cos(q2 + qT) + L4*...
         cos(q1 + qT) - ellzcmT*cos(qT) - ellycmT*sin(qT)) + L2*dq2*...
         cos(q2 + qT) + L4*dq1*cos(q1 + qT))^2)/2 + (L2^2*dq2^2*...
         mH)/2 + (L4^2*dq1^2*mH)/2 + (L2^2*dqT^2*mH)/2 + (L4^2*dqT^2*...
         mH)/2 + L2^2*dq2*dqT*mH + L4^2*dq1*dqT*mH + L2*L4*dqT^2*mH*...
         cos(q1 - q2) + L2*L4*dq1*dq2*mH*cos(q1 - q2) + L2*L4*dq1*dqT*mH*...
         cos(q1 - q2) + L2*L4*dq2*dqT*mH*cos(q1 - q2);
KET=zeros(1,1);
KET(1,1)=(mT*(dqT*(L2*sin(q2 + qT) + L4*sin(q1 + qT) + ellycmT*...
         cos(qT) - ellzcmT*sin(qT)) + L2*dq2*sin(q2 + qT) + L4*dq1*...
         sin(q1 + qT))^2)/2 + (JcmT*dqT^2)/2 + (mT*(dqT*(L2*...
         cos(q2 + qT) + L4*cos(q1 + qT) - ellzcmT*cos(qT) - ellycmT*...
         sin(qT)) + L2*dq2*cos(q2 + qT) + L4*dq1*cos(q1 + qT))^2)/2;
KE1=zeros(1,1);
KE1(1,1)=(Jcm1*(dq1 + dqT)^2)/2 + (m1*(dqT*(L2*cos(q2 + qT) + L4*...
         cos(q1 + qT) - ellzcm1*cos(q1 + qT) - ellycm1*...
         sin(q1 + qT)) - dq1*(ellzcm1*cos(q1 + qT) - L4*...
         cos(q1 + qT) + ellycm1*sin(q1 + qT)) + L2*dq2*...
         cos(q2 + qT))^2)/2 + (m1*(dq1*(L4*sin(q1 + qT) + ellycm1*...
         cos(q1 + qT) - ellzcm1*sin(q1 + qT)) + dqT*(L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm1*cos(q1 + qT) - ellzcm1*sin(q1 + qT)) + L2*...
         dq2*sin(q2 + qT))^2)/2;
KE2=zeros(1,1);
KE2(1,1)=(Jcm2*(dq2 + dqT)^2)/2 + (m2*(dqT*(L2*cos(q2 + qT) + L4*...
         cos(q1 + qT) - ellzcm2*cos(q2 + qT) - ellycm2*...
         sin(q2 + qT)) - dq2*(ellzcm2*cos(q2 + qT) - L2*...
         cos(q2 + qT) + ellycm2*sin(q2 + qT)) + L4*dq1*...
         cos(q1 + qT))^2)/2 + (m2*(dq2*(L2*sin(q2 + qT) + ellycm2*...
         cos(q2 + qT) - ellzcm2*sin(q2 + qT)) + dqT*(L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm2*cos(q2 + qT) - ellzcm2*sin(q2 + qT)) + L4*...
         dq1*sin(q1 + qT))^2)/2;
KE3=zeros(1,1);
KE3(1,1)=(m3*(dqT*(L2*sin(q2 + qT) - L1*sin(q1 + qT) + L4*...
         sin(q1 + qT) + ellycm3*cos(q2 + qT) - ellzcm3*...
         sin(q2 + qT)) + dq2*(L2*sin(q2 + qT) + ellycm3*...
         cos(q2 + qT) - ellzcm3*sin(q2 + qT)) - dq1*(L1*sin(q1 + qT) - L4*...
         sin(q1 + qT)))^2)/2 + (Jcm3*(dq2 + dqT)^2)/2 + (m3*(dq2*(ellzcm3*...
         cos(q2 + qT) - L2*cos(q2 + qT) + ellycm3*sin(q2 + qT)) + dq1*(L1*...
         cos(q1 + qT) - L4*cos(q1 + qT)) + dqT*(L1*cos(q1 + qT) - L2*...
         cos(q2 + qT) - L4*cos(q1 + qT) + ellzcm3*cos(q2 + qT) + ellycm3*...
         sin(q2 + qT)))^2)/2;
KE4=zeros(1,1);
KE4(1,1)=((dq1 + dqT)^2*(Jcm4 + L4^2*m4 + ellycm4^2*...
         m4 + ellzcm4^2*m4 - 2*L4*ellzcm4*m4))/2;
KEm1=zeros(1,1);
KEm1(1,1)=(Jgear1*(dq1 + dqT)^2)/2 + (Jrotor1*(dqT + R1*...
         dq1)^2)/2;
KEm2=zeros(1,1);
KEm2(1,1)=(Jgear2*(dq2 + dqT)^2)/2 + (Jrotor2*(dqT + R2*...
         dq2)^2)/2;
KE1L=zeros(1,1);
KE1L(1,1)=(Jcm1*(dq1L + dqT)^2)/2 + (m1*(dqT*(L2*...
         cos(q2 + qT) + L4*cos(q1 + qT) - ellzcm1*cos(q1L + qT) - ellycm1*...
         sin(q1L + qT)) - dq1L*(ellzcm1*cos(q1L + qT) + ellycm1*...
         sin(q1L + qT)) + L2*dq2*cos(q2 + qT) + L4*dq1*...
         cos(q1 + qT))^2)/2 + (m1*(dq1L*(ellycm1*cos(q1L + qT) - ellzcm1*...
         sin(q1L + qT)) + dqT*(L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm1*cos(q1L + qT) - ellzcm1*...
         sin(q1L + qT)) + L2*dq2*sin(q2 + qT) + L4*dq1*sin(q1 + qT))^2)/2;
KE2L=zeros(1,1);
KE2L(1,1)=(Jcm2*(dq2L + dqT)^2)/2 + (m2*(dqT*(L2*...
         cos(q2 + qT) + L4*cos(q1 + qT) - ellzcm2*cos(q2L + qT) - ellycm2*...
         sin(q2L + qT)) - dq2L*(ellzcm2*cos(q2L + qT) + ellycm2*...
         sin(q2L + qT)) + L2*dq2*cos(q2 + qT) + L4*dq1*...
         cos(q1 + qT))^2)/2 + (m2*(dq2L*(ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + dqT*(L2*sin(q2 + qT) + L4*...
         sin(q1 + qT) + ellycm2*cos(q2L + qT) - ellzcm2*...
         sin(q2L + qT)) + L2*dq2*sin(q2 + qT) + L4*dq1*sin(q1 + qT))^2)/2;
KE3L=zeros(1,1);
KE3L(1,1)=(m3*(L1*dq1L*cos(q1L + qT) - L4*dq1*cos(q1 + qT) - L2*...
         dq2*cos(q2 + qT) - L2*dqT*cos(q2 + qT) - L4*dqT*...
         cos(q1 + qT) + L1*dqT*cos(q1L + qT) + dq2L*ellzcm3*...
         cos(q2L + qT) + dqT*ellzcm3*cos(q2L + qT) + dq2L*ellycm3*...
         sin(q2L + qT) + dqT*ellycm3*sin(q2L + qT))^2)/2 + (Jcm3*...
         (dq2L + dqT)^2)/2 + (m3*(L2*dq2*sin(q2 + qT) + L4*dq1*...
         sin(q1 + qT) - L1*dq1L*sin(q1L + qT) + L2*dqT*sin(q2 + qT) + L4*...
         dqT*sin(q1 + qT) - L1*dqT*sin(q1L + qT) + dq2L*ellycm3*...
         cos(q2L + qT) + dqT*ellycm3*cos(q2L + qT) - dq2L*ellzcm3*...
         sin(q2L + qT) - dqT*ellzcm3*sin(q2L + qT))^2)/2;
KE4L=zeros(1,1);
KE4L(1,1)=(m4*(L2*dq2L*cos(q2L + qT) - L4*dq1*cos(q1 + qT) - L2*...
         dq2*cos(q2 + qT) - L2*dqT*cos(q2 + qT) - L4*dqT*...
         cos(q1 + qT) + L2*dqT*cos(q2L + qT) + dq1L*ellzcm4*...
         cos(q1L + qT) + dqT*ellzcm4*cos(q1L + qT) + dq1L*ellycm4*...
         sin(q1L + qT) + dqT*ellycm4*sin(q1L + qT))^2)/2 + (Jcm4*...
         (dq1L + dqT)^2)/2 + (m4*(L2*dq2*sin(q2 + qT) + L4*dq1*...
         sin(q1 + qT) - L2*dq2L*sin(q2L + qT) + L2*dqT*sin(q2 + qT) + L4*...
         dqT*sin(q1 + qT) - L2*dqT*sin(q2L + qT) + dq1L*ellycm4*...
         cos(q1L + qT) + dqT*ellycm4*cos(q1L + qT) - dq1L*ellzcm4*...
         sin(q1L + qT) - dqT*ellzcm4*sin(q1L + qT))^2)/2;
KEm1L=zeros(1,1);
KEm1L(1,1)=(Jgear1*(dq1L + dqT)^2)/2 + (Jrotor1*(dqT + R1*...
         dq1L)^2)/2;
KEm2L=zeros(1,1);
KEm2L(1,1)=(Jgear2*(dq2L + dqT)^2)/2 + (Jrotor2*(dqT + R2*...
         dq2L)^2)/2;
%%%%
%%%%
return