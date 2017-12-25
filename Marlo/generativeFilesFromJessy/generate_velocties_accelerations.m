% Modified April 9th, 2013 BAG for learning excercise
% generate_velocties_accelerations.m
%
% File to automatically build up the .m-files needed for our simualtor
%

%load Mat/work_symb_model_abs;
fcn_name = 'VelAccelAtrias2D';

disp(['[creating ',upper(fcn_name),'.m]']);
fid = fopen([fcn_name,'.m'],'w');
n=max(size(q));
fprintf(fid,['function [',StringVelAccelVector,'] = '...
    ' %s(q,dq)\n'],fcn_name);
fprintf(fid,'%s','%%%%');
fprintf(fid,'%%%%%s\n',['  ',fcn_name,'.m']);
fprintf(fid,'%%%%%s',['%%  ',datestr(now)]);
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%% Authors(s): Grizzle');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
TempParams='[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2] = modelParametersAtrias_v05;';
Temp=fixlength(TempParams,'*+- ',65,'         ');
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

%
% Build up the name vector
Names_size=size(StringVelAccelVector,2);
Names=cell(Names_size,1);
j=0;k=0; len_StringVelAccelVector=length(StringVelAccelVector);
for i=1:len_StringVelAccelVector
    if StringVelAccelVector(i)==' '
        k=k+1;
        Names(k)=cellstr(StringVelAccelVector(j+1:i-1));
        j=i;
    end
end
k=k+1;
Names(k)=cellstr(StringVelAccelVector(j+1:i))
Names_size=k;

for i=1:Names_size
    variable=eval(char(Names(i)));
    [rvar,cvar]=size(variable);    
    fprintf(fid,'\n%s',[char(Names(i)),'=zeros(',num2str(rvar),',',num2str(cvar),');']);
    for k=1:rvar
        for j=1:cvar
            Temp0=variable(k,j);
            if Temp0 ~= 0
                %ttt = char(vectorize(jac_P(2)));
                Temp1=char(Temp0);
                Temp2=[char(Names(i)),'(',num2str(k),',',num2str(j),')=',Temp1,';'];
                Temp3=fixlength(Temp2,'*+-',65,'         ');
                fprintf(fid,'\n%s',Temp3);
            end
        end
    end
    
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');

fprintf(fid,'\n%s','return');
status = fclose(fid)

return


% ttt = char(vectorize(jac_P(2)));
% fprintf(fid,'jac_P2 = %s;\n\n',fixlength(ttt,'*+-',65,'         '));
