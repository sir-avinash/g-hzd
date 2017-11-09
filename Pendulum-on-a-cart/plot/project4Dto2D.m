



% folderDate = '17-07-24';
folderDate = '17-07-27';	% 1 sec period
set_A = load(['D_aSet_',folderDate]);
% for m = 1:length(set_A.A_xSet)
% for m = 1:5:length(set_A.A_xSet)
for node = 1:20:floor(length(tStar{1})/3)
label = [];
phi = [];
for m = 11
	
% 	folderDate2 = '17-07-23';
	% d = load(['OrbitLibrary_',folderDate2,['_d',num2str(m)]]);
	% [tO, xO, uO, mO] = d.response.unpack;

set_d = load(['D_xSet_',folderDate]);

% for n = 2:length(set_d.d_xSet)-1
for n = 1:length(set_d.d_xSet)
% 	n = 1;

% 	vers = ['_d2',num2str(n),'_o',num2str(m)];
	vers = ['_l',num2str(n),'_o',num2str(m)];	% library L
	
	% dropout infeasible initial condition
	try		
	d = load(['DataFiles\',folderDate,'\Response_',folderDate,vers]);
	[tStar, xStar, uStar, mStar] = d.response.unpack;
% 	for node = 1:10:floor(length(tStar{1})/3)
% 	for node = 250
		
		phi = [phi, [xStar{1}(:,node)]];
		label = [label, uStar{1}(node)];
% 		phi = [[xStar{1}(:,node)]];
% 		label = [uStar{1}(node)];
		
% 	end
	
	catch
		disp(['Load infeasible data on ', num2str(n)]);
		
	end
		
end		% for n
end		% for m

%
normPhi4 = (phi(4,:)-min(phi(4,:)))/(max(phi(4,:)) - min(phi(4,:)));

figure(100+node)

scatter3(phi(1,:), phi(3,:),phi(2,:), [],[normPhi4; 0*normPhi4; 1 - normPhi4]')
xlabel('x')
ylabel('y')
end