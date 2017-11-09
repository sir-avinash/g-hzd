clear

label = [];
phi = [];

folderDate = '17-07-24';
set_A = load(['D_aSet_',folderDate]);
% for m = 1:length(set_A.A_xSet)
% for m = 1:5:length(set_A.A_xSet)
for m = 11
	
% 	folderDate2 = '17-07-23';
	% d = load(['OrbitLibrary_',folderDate2,['_d',num2str(m)]]);
	% [tO, xO, uO, mO] = d.response.unpack;

set_d = load(['D_xSet_',folderDate]);

for n = 1:length(set_d.d_xSet)
% for n = 2:length(set_d.d_xSet)-1
% 	n = 1;

% 	vers = ['_d',num2str(n),'_o',num2str(m)];	% zeros
	vers = ['_d_theta',num2str(n),'_o',num2str(m)];	% library
	
	% dropout infeasible initial condition
	try		
	d = load(['DataFiles\',folderDate,'\Response_',folderDate,vers]);
	[tStar, xStar, uStar, mStar] = d.response.unpack;
	
	t_span = ceil(length(tStar{1})/3);
% 	t_span = 1:floor(length(tStar{1})/3)
	for node = 1:t_span
% 	for node = 1
		
		R = [0 1 0 0; 0 0 0 1];
% 		R = [0 1 0 0; 0 0 0 1];
% 		R = [1 -1 0 0; 0 1*tStar{1}(node) 1 -10*tStar{1}(node)];
% 		R = [1 0 0 0; 0 1 1 0];
% 		R = [1 0 0 0; 0 0 1 0];
% 		R = [1 0 1 0; 0 0 0 -1];
% 		phi = [phi, [R*(xStar{1}(:,node) - xO{1}(:,node));tStar{1}(node);set_A.A_xSet(m)]];
		phi = [phi, [R*xStar{1}(:,node);tStar{1}(node);set_A.A_xSet(m)]];
% 		R_null = [0 1 0 0; 0 0 0 1];
		R_null = [1 -1 0 0; 0 0 1 1];
% 		label = [label, [uStar{1}(node) - uO{1}(:,node); R_null*(xStar{1}(:,node) - xO{1}(:,node))]];
		label = [label, [uStar{1}(node); R_null*(xStar{1}(:,node))]];
% 		uStar_ew = [uStar_ew, 1/(max(uStar{1}) - min(uStar{1}))];

	end
	
	catch
		disp(['Load infeasible data on ', num2str(n)]);
		
	end
		
end		% for n
end		% for m
%
figure(211);clf
n = 1;
% for v = 1;
% for v = 1:80:length(phi);
for v = 1:t_span:length(phi);
% for v = 1:39:length(phi);
hold on
% plot3(phi(3,v:v+39), phi(1,v:v+39), phi(2,v:v+39),'Color',[v/length(phi) 0 1 - v/length(phi)])
plot3(phi(3,v:v+t_span-1), phi(1,v:v+t_span-1), phi(2,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
% plot3(phi(3,v:v+38), phi(1,v:v+38), phi(2,v:v+38),'Color',[v/length(phi) 0 1 - v/length(phi)])
% plot3(phi(4,v:v+39), phi(1,v:v+39), phi(2,v:v+39),'Color',[v/length(phi) 0 1 - v/length(phi)])
% plot3(phi(1,v:v+39), phi(2,v:v+39), label(1,v:v+39),'Color',[v/length(phi) 0 1 - v/length(phi)])
end
hold off
% view([-50 40])
view([45 27])

%%

% for j = 1:1:80
for j = 1:10:node
% for j = 1
figure(203 + j*10);clf

	n = 1+j - 1:80:length(phi);
	v = linspace(0,1,length(n));
% 	scatter3(phi(1,n), phi(2,n),label(1,n), [],[v; 0*v; 1 - v]')
	scatter(phi(1,n), phi(2,n), [],[v; 0*v; 1 - v]')
% 	view([90 0])

end
	
%%
fun_name = 'nnOrbitLibrary_none';
nnFitReducedGrid

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
