clear

label = zeros(3,1);
% label = zeros(1,1);
phi = zeros(4,1);
% label = [];
% phi = [];
i = 1;

% folderDate = '17-09-08';	% Back stepping
% folderDate = '17-09-09';	% library to equ
folderDate = '17-09-10';	% Back stepping
DataSet = load(['DataSet_',folderDate]);

% for m = 1:length(DataSet.A_xSet)
% for m = 1:5:length(DataSet.A_xSet)
for m = 11
	
% 	folderDate2 = '17-07-23';
	% d = load(['OrbitLibrary_',folderDate2,['_d',num2str(m)]]);
	% [tO, xO, uO, mO] = d.response.unpack;

% DataSet = load(['DataSet_',folderDate]);
J_set = [];
for n = 1:length(DataSet.d_xSet)
% for n = 3:length(set_d.d_xSet)-2
% for n = 1;

% 	vers = ['_z0',num2str(n),'_o',num2str(m)];	% zeros L
	vers = ['_b',num2str(n),'_o',num2str(m)];	% Back stepping
% 	vers = ['_l',num2str(n),'_o',num2str(m)];	% Back stepping
	
	% dropout infeasible initial condition
	try		
	d = load(['DataFiles\',folderDate,'\Response_',folderDate,vers]);
	[tStar, xStar, uStar, mStar] = d.response.unpack;
	xddotStar = d.xddot;
	J_set(n) = d.J;
	
	t_span = ceil(length(tStar{1})/3);
% 	t_span = floor(length(tStar{1})/3);
% 	for node = floor(linspace(1,t_span,40))
	for node = 1:t_span
% 	for node = 1:20:t_span
% 	for node = 1:10:201
		if 1
% 			R = [1 -1 0 0; 0 0 1 -1];
			R = [1 0 0 0; 0 0 1 0];
% 			R = [1 0 1 0; 0 0 0 1];
	% 		R = [1 -1 0 0; 0 1*tStar{1}(node) 1 -10*tStar{1}(node)];
	% 		phi = [phi, [R*(xStar{1}(:,node) - xO{1}(:,node));tStar{1}(node);set_A.A_xSet(m)]];
% 			phi = horzcat(phi, [R*xStar{1}(:,node);tStar{1}(node);set_A.A_xSet(m)]);
			phi(:,i) = [R*xStar{1}(:,node);tStar{1}(node);DataSet.A_xSet(m)];
% 			phi(:,i) = [R*xStar{1}(:,node)*exp(tStar{1}(node));tStar{1}(node);DataSet.A_xSet(m)];
% 			phi(:,i) = [xStar{1}(:,node);tStar{1}(node);set_A.A_xSet(m)];
			R_null = [0 1 0 0; 0 0 0 1];
	% 		label = [label, [uStar{1}(node) - uO{1}(:,node); R_null*(xStar{1}(:,node) - xO{1}(:,node))]];
% 			label = horzcat(label, [uStar{1}(node); R_null*(xStar{1}(:,node))]);
% 			label(:,i) = [uStar{1}(node); R_null*(xStar{1}(:,node))];
% 			label(:,i) = [uStar{1}(node)];
% 			label(:,i) = [xddotStar(2,node); R_null*(xStar{1}(:,node))*exp(tStar{1}(node))];
			label(:,i) = [xddotStar(2,node); R_null*(xStar{1}(:,node))];
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
end		% for m

% normalize label
% label(1,:) = label(1,:)./max(label(1,:));
% label(2,:) = label(2,:)./max(label(2,:));
% label(3,:) = label(3,:)./max(label(3,:));

%%
X = [];
Y = [];
Z = [];
for v = 1:t_span:length(phi);
X = [X;phi(3,v:v+t_span-1)];
Y = [Y;phi(1,v:v+t_span-1)];
Z = [Z;label(2,v:v+t_span-1)];
end


%%
figure(212);clf
% for v = 1;
% t_span = t_span/40;
for v = 1:t_span:length(phi);

hold on
plot3(phi(3,v:v+t_span-1), phi(1,v:v+t_span-1), label(2,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
% plot3(phi(1,v:v+t_span-1), phi(2,v:v+t_span-1), label(2,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
% plot3(phi(5,v:v+t_span-1), phi(1,v:v+t_span-1), phi(2,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
end

surface(X,Y,Z,'FaceAlpha',0.2,'LineStyle','none')
v = 165;
plot3(phi(3,v:v+t_span-1), phi(1,v:v+t_span-1), label(2,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)],'LineWidth',3)

hold off
xlabel('Time')
ylabel('$x_1$')
zlabel('$x_2$')
% view([-0 8])
% view([62 -4])
view([45 27])

%%
X = [];
Y = [];
Z = [];
U = [];
V = [];
W = [];
interval = 5;
for v = 1:t_span:length(phi);
X = [X;phi(3,v:interval:v+t_span-1)];
Y = [Y;phi(1,v:interval:v+t_span-1)];
Z = [Z;label(2,v:interval:v+t_span-1)];

U = [U;ones(size(phi(3,v:interval:v+t_span-1)))];
V = [V;phi(2,v:interval:v+t_span-1)];
W = [W;label(3,v:interval:v+t_span-1)];
end
%%
figure(213);clf
quiver3(X,Y,Z,U,V,W,'AutoScaleFactor',0.6,'MaxHeadSize',10)
xlabel('Time')
ylabel('$x_1$')
zlabel('$x_2$')

%%
figure(214);clf
quiver3(X,Y,Z,U,V,W,'AutoScaleFactor',0.6,'MaxHeadSize',10)
xlabel('Time')
ylabel('$x_1$')
zlabel('$x_2$')


% view([-0 8])
% view([62 -4])
% view([45 27])
