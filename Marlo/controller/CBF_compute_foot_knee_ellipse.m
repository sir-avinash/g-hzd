function [F,hb,gb,Lf_gb,Lg_gb]= CBF_compute_foot_knee_ellipse(q,dq,fq,gq,Nstep,controller,ls_last)

[p4L,p4,EL,ER,ELq,ERq]= LagrangeModelAtriasConstraint2D(q,dq);
[p_knee,E_knee,Eq_knee]= swing_knee_pos(q,dq);
[p_foot,E_foot,Eq_foot]= swing_knee_pos(q,dq);

F=p4L-p4; % distance between two feet
dF=(EL-ER)'*dq;
ELR=EL-ER;ELR=ELR(3:7,:);
Lf2F=(ELq-ERq)+ELR'*fq;
LgLfF=ELR'*gq;

lf=F(1); 
hf=F(2);
% hf=p4L(2);F=[lf;hf];
dlf=dF(1); dhf=dF(2);
L2f_lf=Lf2F(1);L2f_hf=Lf2F(2);
LgLf_lf=LgLfF(1,:);LgLf_hf=LgLfF(2,:);

gamma_b=controller.CBF_gamma_b;
ld=controller.CBF_ld(Nstep);
l_max=ld+controller.stone_size;
l_min=(ld-controller.stone_size)/2;
R1=controller.CBF_R1;
R2=controller.CBF_R2;

% h1=R1+l_max-sqrt(hf^2+(R1+lf)^2);
% dh1=-(hf*dhf+(R1+lf)*dlf)/sqrt(hf^2+(R1+lf)^2);
% N_d2h1=(hf^2+(R1+lf)^2)^(-3/2)*(hf*dhf+(R1+lf)*dlf)^2-(hf^2+(R1+lf)^2)^(-1/2)*(dhf^2+dlf^2);
% M_d2h1=-(hf^2+(R1+lf)^2)^(-1/2);
% L2f_h1=N_d2h1+M_d2h1*(hf*L2f_hf+(R1+lf)*L2f_lf);
% LgLf_h1=M_d2h1*(hf*LgLf_hf+(R1+lf)*LgLf_lf);
% 
% h2=sqrt((R2+hf)^2+(lf-l_min)^2)-sqrt(R2^2+l_min^2);
% dh2=((R2+hf)*dhf+(lf-l_min)*dlf)/sqrt((R2+hf)^2+(lf-l_min)^2);
% N_d2h2=-((R2+hf)^2+(lf-l_min)^2)^(-3/2)*((R2+hf)*dhf+(lf-l_min)*dlf)^2+((R2+hf)^2+(lf-l_min)^2)^(-1/2)*(dhf^2+dlf^2);
% M_d2h2=((R2+hf)^2+(lf-l_min)^2)^(-1/2);
% L2f_h2=N_d2h2+M_d2h2*((R2+hf)*L2f_hf+(lf-l_min)*L2f_lf);
% LgLf_h2=M_d2h2*((R2+hf)*LgLf_hf+(lf-l_min)*LgLf_lf);

h1=(R1+l_max)^2-(hf^2+(R1+lf)^2);
dh1=-2*hf*dhf-2*(R1+lf)*dlf;
L2f_h1=-2*dhf^2-2*dlf^2-2*hf*L2f_hf-2*(R1+lf)*L2f_lf;
LgLf_h1=-2*hf*LgLf_hf-2*(R1+lf)*LgLf_lf;

% h2=(R2+hf)^2+(lf-l_min)^2-(R2^2+l_min^2);
% dh2=2*(R2+hf)*dhf+2*(lf-l_min)*dlf;
% L2f_h2=2*dhf^2+2*dlf^2+2*(R2+hf)*L2f_hf+2*(lf-l_min)*L2f_lf;
% LgLf_h2=2*(R2+hf)*LgLf_hf+2*(lf-l_min)*LgLf_lf;
% 
% hf=hf+0.01; % put offset for scuffing constraint (hf>=-offset)
% gb1=gamma_b*h1+dh1;
% gb2=gamma_b*h2+dh2;
% gbf=gamma_b*hf+dhf;
% hb=[h1;h2;hf];
% gb=[gb1;gb2;gbf];
% 
% Lf_gb1=gamma_b*dh1+L2f_h1; Lg_gb1=LgLf_h1;
% Lf_gb2=gamma_b*dh2+L2f_h2; Lg_gb2=LgLf_h2;
% Lf_gbf=gamma_b*dhf+L2f_hf; Lg_gbf=LgLf_hf;
% Lf_gb=[Lf_gb1; Lf_gb2; Lf_gbf]; Lg_gb=[Lg_gb1; Lg_gb2; Lg_gbf];

% extend the circle O2 to avoid scuffing
l0=ls_last-controller.CBF_delta_l0;
l_min1=l_min-l0/2;
l_min2=l_min+l0/2;
h2=(R2+hf)^2+(lf-l_min1)^2-(R2^2+l_min2^2);
dh2=2*(R2+hf)*dhf+2*(lf-l_min1)*dlf;
L2f_h2=2*dhf^2+2*dlf^2+2*(R2+hf)*L2f_hf+2*(lf-l_min1)*L2f_lf;
LgLf_h2=2*(R2+hf)*LgLf_hf+2*(lf-l_min1)*LgLf_lf;

gb1=gamma_b*h1+dh1;
gb2=gamma_b*h2+dh2;
hb=[h1;h2];
gb=[gb1;gb2];

Lf_gb1=gamma_b*dh1+L2f_h1; Lg_gb1=LgLf_h1;
Lf_gb2=gamma_b*dh2+L2f_h2; Lg_gb2=LgLf_h2;
Lf_gb=[Lf_gb1; Lf_gb2]; Lg_gb=[Lg_gb1; Lg_gb2];