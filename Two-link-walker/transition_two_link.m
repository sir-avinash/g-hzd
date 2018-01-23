function [x_new,z2_new]=transition_two_link(x)


[r,m,Mh,g]=model_params_two_link;

th1=x(1); th2=x(2); 

% De matrix

De=zeros(4,4);
De(1,1)=1/4*r^2*(5*m+4*Mh);
De(1,2)=-1/2*r^2*m*(cos(th1)*cos(th2)+sin(th1)*sin(th2));
De(1,3)=1/2*r*cos(th1)*(3*m+2*Mh);
De(1,4)=-1/2*r*sin(th1)*(3*m+2*Mh);
De(2,1)=-1/2*r^2*m*(cos(th1)*cos(th2)+sin(th1)*sin(th2));
De(2,2)=1/4*r^2*m;
De(2,3)=-1/2*m*r*cos(th2);
De(2,4)=1/2*r*sin(th2)*m;
De(3,1)=1/2*r*cos(th1)*(3*m+2*Mh);
De(3,2)=-1/2*m*r*cos(th2);
De(3,3)=2*m+Mh;
De(4,1)=-1/2*r*sin(th1)*(3*m+2*Mh);
De(4,2)=1/2*r*sin(th2)*m;
De(4,4)=2*m+Mh;


% E matrix
E=zeros(2,4);
E(1,1)=r*cos(th1);
E(1,2)=-r*cos(th2);
E(1,3)=1;
E(2,1)=-r*sin(th1);
E(2,2)=r*sin(th2);
E(2,4)=1;

% See Grizzle's paper, page 28 for equation...
tmp_vec=inv([De -E';E zeros(2)])*[De*[x(3:4)';zeros(2,1)];zeros(2,1)];

x_new(1)=x(2);
x_new(2)=x(1);
x_new(3)=tmp_vec(2);
x_new(4)=tmp_vec(1);
x_new(5)=tmp_vec(5);
x_new(6)=tmp_vec(6);
z2_new=tmp_vec(4);
