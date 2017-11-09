clear

% label = zeros(3,1);
label = zeros(1,1);
phi = zeros(5,1);
% label = [];
% phi = [];
i = 1;

folderDate = '17-06-28';	% full state
% folderDate = '17-07-24';	
% folderDate = '17-07-26';	% Equ only	
% folderDate = '17-07-27';	
% folderDate = '17-08-03';	% Back stepping
% folderDate = '17-08-04';	% Back stepping

d_x = assignDeltaGrid();
% set_A = load(['D_aSet_',folderDate]);

% for m = 1:length(set_A.A_xSet)
% for m = 1:5:length(set_A.A_xSet)
% for m = 11
for n = 1:length(d_x)
% for n = 3:length(set_d.d_xSet)-2
% for n = 1;

% 	d = load(['Response_',folderDate,['_d',num2str(n)]]);
% 	[tO, xO, uO, mO] = d.response.unpack;

% set_d = load(['D_xSet_',folderDate]);



% 	vers = ['_b',num2str(n),'_o',num2str(m)];	% zeros L
% 	vers = ['_bs',num2str(n),'_o',num2str(m)];	% zeros L
% 	vers = ['_bb',num2str(n),'_o',num2str(m)];	% zeros L
% 	vers = ['_z',num2str(n),'_o',num2str(m)];	% zeros L
% 	vers = ['_z0',num2str(n),'_o',num2str(m)];	% zeros L
% 	vers = ['_zz',num2str(n),'_o',num2str(m)];	% zeros L
% 	vers = ['_l',num2str(n),'_o',num2str(m)];	% library L
% 	vers = ['_d2',num2str(n),'_o',num2str(m)];	% library L
% 	vers = ['_d_full',num2str(n),'_o',num2str(m)];	% none L
	
	% dropout infeasible initial condition
	try		
	d = load(['DataFiles\',folderDate,'\Response_',folderDate,['_d',num2str(n)]]);
	[tStar, xStar, uStar, mStar] = d.response.unpack;
	
% 	t_span = ceil(length(tStar{1})/3);
	t_span = floor(length(tStar{1})/3);
% 	for node = floor(linspace(1,t_span,40))
	for node = 1:t_span
% 	for node = 1:20:t_span
% 	for node = 1:10:201
		if 1
% 			R = [1 -1 0 0; 0 0 1 -1];
% 			R = [1 0 0 0; 0 0 1 0];
% 			R = [1 0 1 0; 0 0 0 1];
	% 		R = [1 -1 0 0; 0 1*tStar{1}(node) 1 -10*tStar{1}(node)];
	% 		phi = [phi, [R*(xStar{1}(:,node) - xO{1}(:,node));tStar{1}(node);set_A.A_xSet(m)]];
% 			phi = horzcat(phi, [R*xStar{1}(:,node);tStar{1}(node);set_A.A_xSet(m)]);
% 			phi(:,i) = [R*xStar{1}(:,node);tStar{1}(node);set_A.A_xSet(m)];
			phi(:,i) = [xStar{1}(:,node);tStar{1}(node)];
% 			R_null = [0 1 0 0; 0 0 0 1];
	% 		label = [label, [uStar{1}(node) - uO{1}(:,node); R_null*(xStar{1}(:,node) - xO{1}(:,node))]];
% 			label = horzcat(label, [uStar{1}(node); R_null*(xStar{1}(:,node))]);
% 			label(:,i) = [uStar{1}(node); R_null*(xStar{1}(:,node))];
			label(:,i) = [uStar{1}(node)];
% 			label(:,i) = [(xStar{1}(4,node))];
		else
			phi = [phi, [xStar{1}(:,node);tStar{1}(node)]];
			label = [label, uStar{1}(node)];
		end
		i = i+1;
	end
	
	catch
		disp(['Load infeasible data on ', num2str(n)]);
	end
		
end		% for n
% end		% for m

% normalize label
% label(1,:) = label(1,:)./max(label(1,:));
% label(2,:) = label(2,:)./max(label(2,:));
% label(3,:) = label(3,:)./max(label(3,:));
%% visualize the training data
figure(212);clf
% for v = 1;
% t_span = t_span/40;
for v = 1:t_span:length(phi);

hold on
plot3(phi(3,v:v+t_span-1), phi(1,v:v+t_span-1), phi(2,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
% plot3(phi(1,v:v+t_span-1), phi(2,v:v+t_span-1), label(1,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
% plot3(phi(5,v:v+t_span-1), phi(1,v:v+t_span-1), phi(2,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
end
hold off
% view([-0 8])
% view([62 -4])
% view([45 27])

	
%%
fun_name = ['nnEquFull',datestr(now,'ddmmyy')];
% fun_name = ['nnEquZero0_raw',datestr(now,'ddmmyy')];
% fun_name = ['nnEquLibrary_raw',datestr(now,'ddmmyy')];

% fun_name = ['nnOrbitZero_raw',datestr(now,'ddmmyy')];
% fun_name = ['nnOrbitLibrary_raw2',datestr(now,'ddmmyy')];
nnFitReducedGrid

%%

% for j = 1:1:80
for j = 1:10:node
% for j = 1
figure(203 + j*10);clf

	n = 1+j - 1:400:length(phi);
	v = linspace(0,1,length(n));
	scatter3(phi(1,n), phi(2,n),label(1,n), [],[v; 0*v; 1 - v]')
% 	scatter(phi(1,n), phi(2,n), [],[v; 0*v; 1 - v]')
% 	view([90 0])

end

%%
figure(100)
% figure
plot(1:length(label), [label; y])
% plot(1:length(label), [label])
%%
figure(101)
scatter3(phi(1,:), phi(2,:), label)
hold on
scatter3(phi(1,:), phi(2,:), y,'r')
hold off

%%
[X,Y] = meshgrid(-2:0.1:2,-2:0.1:2);
phi_test = [X(:), Y(:), zeros(size(X(:)))+0];
% label_test = nnControllerEquilibriumReduced(phi_test');
label_test  = nnControllerEquilibriumReducedGrid(phi_test');
Z = reshape(label_test(1,:), size(X));

figure(200);

n = 1;
% v = (1+40*n:40*(n+1));
v = n:40:1000;
scatter3(phi(1,v), phi(2,v), label(1,v),'r')
hold on
surface(X, Y, Z)

hold off
view([-50 40])
