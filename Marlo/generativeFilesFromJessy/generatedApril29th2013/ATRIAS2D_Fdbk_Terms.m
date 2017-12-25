function [h0,jacob_h0,jacob_jacobh0dq]= ATRIAS2D_Fdbk_Terms(q,dq,leg)
%%%%%%  ATRIAS2D_Fdbk_Terms.m
%%%%  29-Apr-2013 18:06:55
%%%%
%%%% Authors(s): Grizzle
%%%%
%%%%
%%%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)
%%%%                 D(q)ddq + C(q,dq)*dq + G(q) = B*tau
%%%%
%%%%
[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ...
         ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT ...
         JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 ...
         Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;
%%%%
%%%%[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;
%%%%
if nargin < 3, leg=0; end
%%%%
qT=q(1);  dqT=dq(1);
q1=q(2);  dq1=dq(2);
q2=q(3);  dq2=dq(3);
q1L=q(4);  dq1L=dq(4);
q2L=q(5);  dq2L=dq(5);
%%%%
%%%%
h0=zeros(4,1);
if leg ==0
h0(1)=q1/2 + q2/2;
h0(2)=q1L/2 + q2L/2;
h0(3)=q2 - q1;
h0(4)=q2L - q1L;
elseif leg ==1
h0(1)=q1/2 + q2/2;
h0(2)=q1L/2 + q2L/2;
h0(3)=q2 - q1;
h0(4)=q2L - q1L;
end
%%%%
%%%%
jacob_h0=zeros(4,5);
if leg ==0
jacob_h0(1,2)=1/2;
jacob_h0(1,3)=1/2;
jacob_h0(2,4)=1/2;
jacob_h0(2,5)=1/2;
jacob_h0(3,2)=-1;
jacob_h0(3,3)=1;
jacob_h0(4,4)=-1;
jacob_h0(4,5)=1;
elseif leg ==1
jacob_h0(1,2)=1/2;
jacob_h0(1,3)=1/2;
jacob_h0(2,4)=1/2;
jacob_h0(2,5)=1/2;
jacob_h0(3,2)=-1;
jacob_h0(3,3)=1;
jacob_h0(4,4)=-1;
jacob_h0(4,5)=1;
end
%%%%
jacob_jacobh0dq=zeros(4,5);
if leg ==0
elseif leg ==1
end
%%%%
%%%%
return