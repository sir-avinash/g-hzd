% Modified April 9th, 2013 BAG for learning excercise
% generate_model.m
%
% File to automatically build up the .m-files needed for our simualtor
%

%load Mat/work_symb_model_abs;
%fcn_name = 'dyn_mod_abs';
fcn_name='LagrangeModelAtrias2D' % name of matlab function we are writing

disp(['[creating ',upper(fcn_name),'.m]']);
fid = fopen([fcn_name,'.m'],'w'); % opens up a file
n=max(size(q));

% fprintf(fid,['function [D,C,G,B,B_springs,B_HarmonicDrive]=' ... % edit to get rid of springs and harmonic drive
%     ' %s(q,dq)\n'],fcn_name);
fprintf(fid,['function [D,C,G,B,B_HarmonicDrive]=' ... % edit to get rid of springs and harmonic drive
    ' %s(q,dq)\n'],fcn_name);


fprintf(fid,'%s','%%%%');
fprintf(fid,'%%%%%s\n',['  ',fcn_name,'.m']);
fprintf(fid,'%%%%%s',['%%  ',datestr(now)]);
fprintf(fid,'\n%s','%%%%');

% fprintf(fid,'\n%s','%%%% Authors(s): Grizzle'); 
fprintf(fid,'\n%s','%%%% Authors(s): Griffin version of Grizzle code'); 

fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');

% fprintf(fid,'\n%s','%%%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12)');
% fprintf(fid,'\n%s','%%%%                 D(q)ddq + C(q,dq)*dq + G(q) + DampingSpringTorque = B*tau');
fprintf(fid,'\n%s','%%%% Model NOTATION: Spong and Vidyasagar, page 142, Eq. (6.3.12) (equation changed to removing DampingSpringTorque)');
fprintf(fid,'\n%s','%%%%                 D(q)ddq + C(q,dq)*dq + G(q) = B*tau');

fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
TempParams='[g mTotal L1 L2 L3 L4 m1 m2 m3 m4 Jcm1 Jcm2 Jcm3 Jcm4 ellzcm1 ellzcm2 ellzcm3 ellzcm4 ellycm1 ellycm2 ellycm3 ellycm4 LT mT JcmT ellzcmT ellycmT mH JcmH K1 K2 Kd1 Kd2 Jrotor1 Jrotor2 Jgear1  Jgear2 R1  R2 Kfric_HarmonicDrive] = modelParametersAtrias_v05;';
Temp=fixlength(TempParams,'*+- ',65,'         ');
fprintf(fid,'\n%s',Temp);
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s',['%%%%',TempParams]);
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
for i=1:n % changes q1's and q2's to qTorso etc.
    Temp1=char(q(i));
    Temp2=[Temp1,'=q(',num2str(i),');  '];
    Temp3=char(dq(i));
    Temp4=[Temp3,'=dq(',num2str(i),');'];
    Temp5=[Temp2,Temp4];
    fprintf(fid,'\n%s',Temp5);
end
fprintf(fid,'\n%s','%%%%'); % write out inertia matrix.
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s',['D=zeros(',num2str(n),',',num2str(n),')*q(1);']);
for i=1:n
    for j=1:n
        Temp0=D(i,j); % symbolic code of inertia matrix
        if Temp0 ~= 0
            Temp1=char(Temp0); % turns into character string
            Temp2=['D(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         '); % matlab gets mad if columns are too great of length, so this line adds dot dot dot in the right place
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
            Temp3=fixlength(Temp2,'*+-',65,'         ');
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
    Temp3=fixlength(Temp2,'*+-',65,'         ');
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
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');

% [n,m]=size(B_springs);
% fprintf(fid,'\n%s',['B_springs=zeros(',num2str(n),',',num2str(m),');']); % Don't need
% for i=1:n
%     for j=1:m
%         Temp0=B_springs(i,j);
%         if Temp0 ~= 0
%             Temp1=char(Temp0);
%             Temp2=['B_springs(',num2str(i),',',num2str(j),')=',Temp1,';'];
%             Temp3=fixlength(Temp2,'*+-',65,'         ');
%             fprintf(fid,'\n%s',Temp3);
%         end
%     end
% end

fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
[n,m]=size(B_HarmonicDrive);
fprintf(fid,'\n%s',['B_HarmonicDrive=zeros(',num2str(n),',',num2str(m),')*q(1);']);
for i=1:n
    for j=1:m
        Temp0=B_HarmonicDrive(i,j);
        if Temp0 ~= 0
            Temp1=char(Temp0);
            Temp2=['B_HarmonicDrive(',num2str(i),',',num2str(j),')=',Temp1,';'];
            Temp3=fixlength(Temp2,'*+-',65,'         ');
            fprintf(fid,'\n%s',Temp3);
        end
    end
end
fprintf(fid,'\n%s','%%%%');
fprintf(fid,'\n%s','%%%%');
% [n,m]=size(E); % Currently commented for impact model BAG April 29th, 2013
% fprintf(fid,'\n%s',['E=zeros(',num2str(n),',',num2str(m),');']);
% for i=1:n
%     for j=1:m
%         Temp0=E(i,j);
%         if Temp0 ~= 0
%             Temp1=char(Temp0);
%             Temp2=['E(',num2str(i),',',num2str(j),')=',Temp1,';'];
%             Temp3=fixlength(Temp2,'*+-',65,'         ');
%             fprintf(fid,'\n%s',Temp3);
%         end
%     end
% end


fprintf(fid,'\n%s','end'); % could also do end
status = fclose(fid)


return

% ttt = char(vectorize(jac_P(2)));
% fprintf(fid,'jac_P2 = %s;\n\n',fixlength(ttt,'*+-',65,'         '));
