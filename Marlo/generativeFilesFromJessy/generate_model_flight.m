% generate_model.m
%
% File to automatically build up the .m-files needed for our simualtor
%

%load Mat/work_symb_model_abs;
%fcn_name = 'dyn_mod_abs';

length_cut_k = 1;

disp(['[creating ',upper(fcn_name),'.m]']);
fid = fopen([fcn_name,'.m'],'w');
n=max(size(q));
fprintf(fid,['function [D,C,G,B,DampingSpringTorque,EL,ER]=' ...
    ' %s(q,dq)\n'],fcn_name);
fprintf(fid,'%s','%%%%');
fprintf(fid,'%%%%%s\n',['  ',fcn_name,'.m']);
fprintf(fid,'%%%%%s',['%%  ',datestr(now)]);
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%% Authors(s): Grizzle');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)');
fprintf(fid,'\n%s','%%%%                 D(q)ddq + C(q,dq)*dq + G(q) + DampingSpringTorque = B*tau + EL*GroundReactionForceLeft + ER*GroundReactionForceRight');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
TempParams='[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;';
Temp=fixlength(TempParams,'*+- ',65*length_cut_k,'         ');
fprintf(fid,'\n%s',Temp);
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s',['%%%%',TempParams]);
fprintf(fid,'\n%s','%%%%');
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
fprintf(fid,'\n%s',['D=zeros(',num2str(n),',',num2str(n),')*q(1);']);
for i=1:n
    for j=1:n
        Temp0=D(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['D(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65*length_cut_k,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s',['C=zeros(',num2str(n),',',num2str(n),')*q(1);']);
for i=1:n
    for j=1:n
        Temp0=C(i,j);
        if Temp0 ~= 0
            %ttt = char(vectorize(jac_P(2)));
            Temp1=char(Temp0);
            Temp2=['C(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65*length_cut_k,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s',['G=zeros(',num2str(n),',1)*q(1);']);
for i=1:n
    Temp1=char(G(i));
    Temp2=['G(',num2str(i),')=',Temp1,';'];
    Temp3=fixlength(Temp2,'*+-',65*length_cut_k,'         ');
    fprintf(fid,'\n%s',Temp3);
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
[n,m]=size(B);
fprintf(fid,'\n%s',['B=zeros(',num2str(n),',',num2str(m),')*q(1);']);
for i=1:n
    for j=1:m
        Temp0=B(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['B(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65*length_cut_k,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s',['DampingSpringTorque=zeros(',num2str(n),',1)*q(1);']);
for i=1:n
    Temp1=char(DampingSpringTorque(i));
    Temp2=['DampingSpringTorque(',num2str(i),')=',Temp1,';'];
    Temp3=fixlength(Temp2,'*+-',65*length_cut_k,'         ');
    fprintf(fid,'\n%s',Temp3);
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
[n,m]=size(EL);
fprintf(fid,'\n%s',['EL=zeros(',num2str(n),',',num2str(m),')*q(1);']);
for i=1:n
    for j=1:m
        Temp0=EL(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['EL(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65*length_cut_k,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
[n,m]=size(ER);
fprintf(fid,'\n%s',['ER=zeros(',num2str(n),',',num2str(m),')*q(1);']);
for i=1:n
    for j=1:m
        Temp0=ER(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['ER(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65*length_cut_k,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end

fprintf(fid,'\n%s','return');
status = fclose(fid)


return

% ttt = char(vectorize(jac_P(2)));
% fprintf(fid,'jac_P2 = %s;\n\n',fixlength(ttt,'*+-',65*length_cut_k,'         '));
