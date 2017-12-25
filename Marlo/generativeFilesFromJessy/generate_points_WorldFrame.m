% Modified April 9th, 2013 BAG for learning excercise
% generate_points_WorldFrame.m
%
% File to automatically build up the .m-files needed for our simualtor
%

%load Mat/work_symb_model_abs;
%fcn_name = 'dyn_mod_abs';

disp(['[creating ',upper(fcn_name),'.m]']);
fid = fopen([fcn_name,'.m'],'w');
n=max(size(q));
fprintf(fid,['function [',StringPointsVector,'] = '...
    ' %s(q,pFootStance)\n'],fcn_name);
fprintf(fid,'%s','%%%%');
fprintf(fid,'%%%%%s\n',['  ',fcn_name,'.m']);
fprintf(fid,'%%%%%s',['%%  ',datestr(now)]);
fprintf(fid,'\n%s','%%%%');

fprintf(fid,'\n%s','%%%% Authors(s): Griffin (Grizzle original)');

fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','if nargin <2, pFootStance=[0;0]; end');
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
    fprintf(fid,'\n%s',Temp2);
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');

%
% Build up the name vector
PointNames_size=size(PointsVector,2);
PointNames=cell(PointNames_size,1);
j=0;k=0; len_StringPointsVector=length(StringPointsVector);
for i=1:len_StringPointsVector
   if StringPointsVector(i)==' '
      k=k+1;
      PointNames(k)=cellstr(StringPointsVector(j+1:i-1));
      j=i;
   end
end
k=k+1;
PointNames(k)=cellstr(StringPointsVector(j+1:i))
PointNames_size=k;

for i=1:PointNames_size
    Temp1=char(PointNames(i));
    Tempx=char(PointsVector(1,i)); 
    Tempy=char(PointsVector(2,i)); 
    TempFinal=[Temp1,'=[pFootStance(1) + ',Tempx,';pFootStance(2) + ',Tempy,'];'];
    TempFinal=fixlength(TempFinal,'*+-;',65,'         ');
    fprintf(fid,'\n%s',TempFinal);
    fprintf(fid,'\n%s','%');
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');

fprintf(fid,'\n%s','return');
status = fclose(fid)

return


% ttt = char(vectorize(jac_P(2)));
% fprintf(fid,'jac_P2 = %s;\n\n',fixlength(ttt,'*+-',65,'         '));
