% generate_fdbk_terms.m
%
% File to automatically build up the .m-files needed for MATLAB simulation
% File Called: fixlength.m
%
disp(['[creating ',upper(fcn_name),'.m]']);
fid = fopen([fcn_name,'.m'],'w');
n=max(size(q));
fprintf(fid,['function [h0,jacob_h0,jacob_jacobh0dq]=' ...
    ' %s(q,dq,leg)\n'],fcn_name);
fprintf(fid,'%s','%%%%');
fprintf(fid,'%%%%%s\n',['  ',fcn_name,'.m']);
fprintf(fid,'%%%%%s',['%%  ',datestr(now)]);
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%% Authors(s): Grizzle');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)');
fprintf(fid,'\n%s','%%%%                 D(q)ddq + C(q,dq)*dq + G(q) = B*tau');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
TempParams='[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;';
Temp=fixlength(TempParams,'*+- ',65,'         ');
fprintf(fid,'\n%s',Temp);
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s',['%%%%',TempParams]);
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','if nargin < 3, leg=0; end');
fprintf(fid,'\n%s','%%%%');
for i=1:n
    Temp1=char(q(i));
    Temp2=[Temp1,'=q(',num2str(i),');  '];
    Temp3=char(dq(i));
    Temp4=[Temp3,'=dq(',num2str(i),');'];
    Temp5=[Temp2,Temp4];
    fprintf(fid,'\n%s',Temp5);
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
[m,temp]=size(h0_leg0);
fprintf(fid,'\n%s',['h0=zeros(',num2str(m),',',num2str(1),');']);
fprintf(fid,'\n%s','if leg ==0');
for j=1:m
    Temp0=h0_leg0(j);
    %STemp0=vectorize(Temp0);
    if Temp0 ~= 0
        Temp1=char(Temp0);
        Temp2=['h0(',num2str(j),')=',Temp1,';'];
        Temp3=fixlength(Temp2,'*+-',65,'         ');
        fprintf(fid,'\n%s',Temp3);
    end
end
fprintf(fid,'\n%s','elseif leg ==1');
for j=1:m
    Temp0=h0_leg1(j);
    %Temp0=vectorize(Temp0);
    if Temp0 ~= 0
        Temp1=char(Temp0);
        Temp2=['h0(',num2str(j),')=',Temp1,';'];
        Temp3=fixlength(Temp2,'*+-',65,'         ');
        fprintf(fid,'\n%s',Temp3);
    end
end
fprintf(fid,'\n%s','end');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');


fprintf(fid,'\n%s',['jacob_h0=zeros(',num2str(m),',',num2str(n),');']);
fprintf(fid,'\n%s','if leg ==0');
for i=1:m
    for j=1:n
        Temp0=jacob_h0_leg0(i,j);
        %Temp0=vectorize(Temp0);
        if Temp0 ~= 0
            %ttt = char(vectorize(jac_P(2)));
            Temp1=char(Temp0);
            Temp2=['jacob_h0(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','elseif leg ==1');
for i=1:m
    for j=1:n
        Temp0=jacob_h0_leg1(i,j);
        %Temp0=vectorize(Temp0);
        if Temp0 ~= 0
            %ttt = char(vectorize(jac_P(2)));
            Temp1=char(Temp0);
            Temp2=['jacob_h0(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','end');
% fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s',['jacob_jacobh0dq=zeros(',num2str(m),',',num2str(n),');']);
fprintf(fid,'\n%s','if leg ==0');
for i=1:m
    for j=1:n
        Temp0=jacob_jacobh0dq_leg0(i,j);
        %Temp0=vectorize(Temp0);
        if Temp0 ~= 0
            %ttt = char(vectorize(jac_P(2)));
            Temp1=char(Temp0);
            Temp2=['jacob_jacobh0dq0(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','elseif leg ==1');
for i=1:m
    for j=1:n
        Temp0=jacob_jacobh0dq_leg1(i,j);
        %Temp0=vectorize(Temp0);
        if Temp0 ~= 0
            %ttt = char(vectorize(jac_P(2)));
            Temp1=char(Temp0);
            Temp2=['jacob_jacobh0dq(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','end');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','return');

status = fclose(fid)

return
