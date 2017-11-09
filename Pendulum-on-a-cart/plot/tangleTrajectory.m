% clear

label = zeros(3,1);
phi = zeros(4,1);
x1 = zeros(2,1,1);
x1_tilde = zeros(2,1,1);
x = zeros(4,1,1);
% label = [];
% phi = [];
i = 1;
j = 1;

% folderDate = '17-07-24';	
% folderDate = '17-07-26';	% Equ only	
% folderDate = '17-07-27';	
% folderDate = '17-08-02';	% Back stepping
% folderDate = '17-08-03';	% Back stepping
% folderDate = '17-08-04';	% Back stepping
% set_A = load(['D_aSet_',folderDate]);

% folderDate = '17-09-09';	% library to equ
folderDate = '17-10-11';	% Back stepping
DataSet = load(['DataSet_',folderDate]);

% for m = 1:length(set_A.A_xSet)
% for m = 1:5:length(set_A.A_xSet)

for m = 11
	
% 	folderDate2 = '17-07-23';
	% d = load(['OrbitLibrary_',folderDate2,['_d',num2str(m)]]);
	% [tO, xO, uO, mO] = d.response.unpack;

% set_d = load(['D_xSet_',folderDate]);

for n = 1:length(DataSet.d_xSet)
% 	for n = 3:5:length(DataSet.d_xSet)
% for n = 1:5:length(set_d.d_xSet)
% 	for n = 1:5
% for n = 2:length(set_d.d_xSet)-1
% for n = [1];

% 	vers = ['_z',num2str(n),'_o',num2str(m)];	% zeros L || with bounded position at 08-02
% 	vers = ['_l',num2str(n),'_o',num2str(m)];	% library L
% 	vers = ['_d2',num2str(n),'_o',num2str(m)];	% library L
% 	vers = ['_d_full',num2str(n),'_o',num2str(m)];	% none L
	vers = ['_b',num2str(n),'_o',num2str(m)];	% back stepping
% 	vers = ['_l',num2str(n),'_o',num2str(m)];	% library L

	% dropout infeasible initial condition
% 	try		
	d = load(['DataFiles\',folderDate,'\Response_',folderDate,vers]);
	[tStar, xStar, uStar, mStar] = d.response.unpack;

	t_span = ceil(length(tStar{1})/3);
% 	t_span = floor(length(tStar{1})/3);
% 	t_span = 40;
% 	t_span = floor(length(tStar{1}));

% 	for node = floor(linspace(1,t_span,40))
% 	for node = 1
	for node = 1:t_span
% 	for node = 1:10:201
% 	for node = 40
	
		if 1
			
			R = [1 0 0 0; 0 0 1 0];
			R_tilde = [1 -1 0 0; 0 0 1 -1];
% 			R = R_set(:,:,node);
% 		    R = R_mean;
% 			R = [1 0 1 -1; 0 0 0 0];
	% 		R = [1 -1 0 0; 0 1*tStar{1}(node) 1 -10*tStar{1}(node)];
	% 		phi = [phi, [R*(xStar{1}(:,node) - xO{1}(:,node));tStar{1}(node);set_A.A_xSet(m)]];
% 			phi = horzcat(phi, [R*xStar{1}(:,node);tStar{1}(node);set_A.A_xSet(m)]);
			phi(:,i) = [R*xStar{1}(:,node);tStar{1}(node);DataSet.A_xSet(m)];
			x1(:,j, node) = [R*xStar{1}(:,node)];
			x(:,j, node) = xStar{1}(:,node);
			x1_tilde(:,j, node) = [R_tilde*xStar{1}(:,node)];
			R_null = [0 1 0 0; 0 0 0 1];
	% 		label = [label, [uStar{1}(node) - uO{1}(:,node); R_null*(xStar{1}(:,node) - xO{1}(:,node))]];
% 			label = horzcat(label, [uStar{1}(node); R_null*(xStar{1}(:,node))]);
			label(:,i) = [uStar{1}(node); R_null*(xStar{1}(:,node))];
% 			label = [label, [uStar{1}(node)]];
		else
			phi = [phi, [xStar{1}(:,node);tStar{1}(node)]];
			label = [label, uStar{1}(node)];
		end
		i = i+1;
		
	end
	j = j+1;
% 	catch
% 		disp(['Load infeasible data on ', num2str(n)]);
% 	end
		
end		% for n
end		% for m


%%
if 0
figure(111);clf
% figure(112);clf
% for v = 1;
% t_span = t_span/40;
for v = 1:t_span:length(phi);

hold on
plot3(phi(3,v:v+t_span-1), phi(1,v:v+t_span-1), phi(2,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])

% plot(phi(3,v:v+t_span-1), phi(1,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
% plot3(phi(3,v:v+t_span-1), phi(1,v:v+t_span-1), label(3,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
end
hold off
xlabel('Time (s)')
ylabel('$p$')
zlabel('$\dot{p}$')
% ylabel('$\dot{p} - \dot{\theta}$')
% view([-0 8])
% view([62 -4])
view([20 0])

end
	
%%
% for j = 1:10:node
close(figure(200))
figure(200);clf
set(gcf, 'Name','featureSinglarity');
m = 0;
for j = [1,20,35,41]
% for j = [1,]
subplot(221 + m)
% figure(212);clf

	n = 1+j - 1:41:length(phi);
	v = linspace(0,1,length(n));
	scatter3(phi(1,n), phi(2,n),label(1,n), [],[v; 0*v; 1 - v]')
% 	scatter(phi(1,n),label(1,n), [],[v; 0*v; 1 - v]')
% 	scatter(phi(1,n), phi(2,n), [],[v; 0*v; 1 - v]')
	view([90 90])
% 	xlabel('Time (s)')
	xlabel('$p$')
	ylabel('$\dot{p}$')
	P = get(gcf,'Position');
	ax = gca;
	ax.YLim = [-2 2];
	ax.XLim = [-2 2];
	ax.TickLabelInterpreter = 'latex';
	t = title(['$t = $ ',(['$',num2str((j-1)*0.05),'$'])],'Interpreter', 'latex');
	t.Position = t.Position + [0.5 0 0];
m = m + 1;
end
scale = 0.6;
set(gcf, 'Position', [P(1) P(2) P(3)*scale P(4)*scale]);

xlim([-2 2])
%%
S1_set = zeros(2,1);
S_set = zeros(4,1);
R_set = zeros(2,4,1);
x1_last = zeros(2,1);
for node = 1:t_span
% for node = 2
	[~,S,~] = svd(x1(:,:,node));
	S1_set(:,node) = [S(1,1), S(2,2)];
	
	[U,S,V] = svd(x(:,:,node));
	S_set(:,node) = diag(S);
	
% 	U2 = U(:,1:2)';
% 	if node > 1
% 		x1_c = U2*ones(4,1);
% 		if norm(x1_c - x1_last) > 1
% 			U2 = -U2;
% 		end
% 	end
% 	x1_last = U2*ones(4,1);
	
	R_set(:,:,node) = U(:,1:2)';
% 	R_set(:,:,node) = U(:,1:2)' + U(:,3:4)';
% 	R_set(:,:,1) = -R_set(:,:,1);
% 	R_set(:,:,end) = -R_set(:,:,end);
	R_mean = mean(R_set(:,:,2:end-1), 3);
end

% %%
% UT = U';
% U11 = UT(1:2, 1:2); U21 = UT(3:4, 1:2);
% U_a = [U11', U21'];
% 
% m = (U_a*UT(:,1:2))\(U_a*UT(:,3:4))

%%
S1_set_tilde = zeros(2,1);
S_set_tilde = zeros(4,1);
R_set_tilde = zeros(2,4,1);
x1_last_tilde = zeros(2,1);
for node = 1:t_span
% for node = 2
	[~,S_tilde,~] = svd(x1_tilde(:,:,node));
	S1_set_tilde(:,node) = [S_tilde(1,1), S_tilde(2,2)];
	
	[U_tilde,S_tilde,V_tilde] = svd(x(:,:,node));
	S_set_tilde(:,node) = diag(S_tilde);
	
% 	U2 = U(:,1:2)';
% 	if node > 1
% 		x1_c = U2*ones(4,1);
% 		if norm(x1_c - x1_last) > 1
% 			U2 = -U2;
% 		end
% 	end
% 	x1_last = U2*ones(4,1);
	
	R_set_tilde(:,:,node) = U_tilde(:,1:2)';
% 	R_set(:,:,node) = U(:,1:2)' + U(:,3:4)';
% 	R_set(:,:,1) = -R_set(:,:,1);
% 	R_set(:,:,end) = -R_set(:,:,end);
	R_mean = mean(R_set_tilde(:,:,2:end-1), 3);
end

% %%
% UT = U';
% U11 = UT(1:2, 1:2); U21 = UT(3:4, 1:2);
% U_a = [U11', U21'];
% 
% m = (U_a*UT(:,1:2))\(U_a*UT(:,3:4))


%%
close(figure(100))
figure(100);clf
P = get(gcf,'Position');
scale = 0.6;
set(gcf, 'Position', [P(1) P(2) P(3)*scale P(4)*scale]);
set(gcf, 'Name','svdCheck');
plot(phi(3, 1:t_span), S1_set','LineWidth',1.5)
hold on
ax = gca;
ax.ColorOrderIndex = 1;
% plot(phi(3, 1:t_span), S_set([1,2],:)','--','LineWidth',1.5)
plot(phi(3, 1:t_span), S1_set_tilde','--','LineWidth',1.5)
hold off
% plot(S_set')
grid on
ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.XTick = [0:.2:2];
xlabel('Time (s)')
% ylabel('Singular Value $\sigma$')
% legend('\sigma_1','\sigma_2','\sigma_{1full}','\sigma_{2full}')
legend('$\sigma_1$','$\sigma_2$','$\tilde{\sigma}_1$','$\tilde{\sigma}_2$')
h = findobj(gcf,'Tag','legend');
set(h,'Interpreter', 'latex')

%


%%
% parentPath = 'C:\Users\xingye\Dropbox (DynamicLegLocomotion)\TeamWide\Dennis\Journal 2017\Graphics\MATLAB\';
% save_figure([parentPath, 'fig'])