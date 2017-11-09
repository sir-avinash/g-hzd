
%%
% label = zeros(3,1);
label = zeros(1,1);
% phi = zeros(4,1);
phi = zeros(5,1);
% label = [];
% phi = [];
i = 1;

folderDate = '17-09-08';	% Full State
DataSet = load(['DataSet_',folderDate]);

for m = 11

J_set = [];
for n = [261:265, 286:290, 311:315, 336:340, 361:365]

	vers = ['_b',num2str(n),'_o',num2str(m)];	% Back stepping
	
	% dropout infeasible initial condition
	d = load(['DataFiles\',folderDate,'\Response_',folderDate,vers]);
	[tStar, xStar, uStar, mStar] = d.response.unpack;
	xddotStar = d.xddot;
	J_set(n) = d.J;
	
% 	t_span = ceil(length(tStar{1})/3);
% 	t_span = floor(length(tStar{1})/3);
	t_span = 1;
	for node = 1:t_span
		phi(:,i) = [[xStar{1}(:,node);tStar{1}(node)]];
		label(:,i) = [uStar{1}(node)];
		i = i+1;
	end
		
end		% for n
end		% for m

%%
num = 20;
p = linspace(-2,2,num);
% tau = linspace(0,2,length(p));
d_p = linspace(-3,3,num);
[X,Y] = meshgrid(p,d_p);
phi_test = [X(:),zeros(length(X(:)), 1), Y(:), zeros(length(X(:)), 2)]';
%
u = nnEquFull260917(phi_test);
U = reshape(u, size(X));

close(figure(200))
figure(200);clf
set(gcf, 'Name','FittingFullState');
hold on
grid on
ax = gca;
ax.TickLabelInterpreter = 'latex';
ax.XTick = [-2:1:2];
ax.YTick = [-3:1:3];
surface(X, Y, U,'FaceAlpha',0.8,'LineStyle','none')
scatter3(phi(1,:), phi(3,:),label(1,:),'r', 'LineWidth', 1)
hold off
view([-117 24])
xlabel('$p$')
ylabel('$\dot{p}$')
zlabel('$\mu$')
P = get(gcf,'Position');
scale = 0.6;
set(gcf, 'Position', [P(1) P(2) P(3)*scale P(4)*scale]);


%%
parentPath = 'C:\Users\xingye\Dropbox (DynamicLegLocomotion)\TeamWide\Dennis\Journal 2017\Graphics\MATLAB\';

save_figure([parentPath, 'fig'], 1)
%%
if 0
num = 20;
p = linspace(-2,2,num);
% tau = linspace(0,2,length(p));
d_p = linspace(-2,2,num);
[X,Y] = meshgrid(p,d_p);
phi = [X(:),zeros(length(X(:)), 1), Y(:), zeros(length(X(:)), 1), zeros(length(X(:)), 1)+2]';
%
u = nnEquFull260917(phi);
U = reshape(u, size(X));

figure(201);clf
% scatter3(X(:), Y(:), u)
% hold on
grid on
surface(X, Y, U)
% hold off
view([50 24])
end

%%
if 0
% label = zeros(3,1);
label = zeros(1,1);
% phi = zeros(4,1);
phi = zeros(5,1);
% label = [];
% phi = [];
i = 1;

folderDate = '17-09-08';	% Full State
DataSet = load(['DataSet_',folderDate]);

for m = 11

J_set = [];
for n = 311:315

	vers = ['_b',num2str(n),'_o',num2str(m)];	% Back stepping
	
	% dropout infeasible initial condition
	d = load(['DataFiles\',folderDate,'\Response_',folderDate,vers]);
	[tStar, xStar, uStar, mStar] = d.response.unpack;
	xddotStar = d.xddot;
	J_set(n) = d.J;
	
	t_span = ceil(length(tStar{1})/3);
% 	t_span = floor(length(tStar{1})/3);
	for node = 1:t_span
		phi(:,i) = [[xStar{1}(:,node);tStar{1}(node)]];
		label(:,i) = [uStar{1}(node)];
		i = i+1;
	end
		
end		% for n
end		% for m


%%
X = [];
Y = [];%Y2 = [];Y3 = [];Y4 = [];
Z = [];
for v = 1:t_span:length(phi);
X = [X;phi(5,v:v+t_span-1)];
Y = [Y;phi(1,v:v+t_span-1)];
% Y2 = [Y2;phi(2,v:v+t_span-1)];
% Y3 = [Y3;phi(3,v:v+t_span-1)];
% Y4 = [Y4;phi(4,v:v+t_span-1)];
Z = [Z;label(1,v:v+t_span-1)];
end
% phi = [Y(:),Y2(:),Y3(:),Y4(:), X(:)]';
u = nnEquFull260917(phi);
U = reshape(u, fliplr(size(X)))';

%%
[qx,qy] = meshgrid(1:41, 1:5);
[qX,qY] = meshgrid(0:42, -1:1e-1:7);
Vq = interp2(qx,qy,Y,qX,qY, 'cubic');
figure(100);clf
hold on
surf(qx,qy,Y)
surf(qX,qY,Vq,'FaceAlpha',0.5,'LineStyle','none')
hold off
%%
figure(212);clf
for v = 1:t_span:length(phi);

hold on
% plot3(phi(5,v:v+t_span-1), phi(1,v:v+t_span-1), label(1,v:v+t_span-1),'Color',[v/length(phi) 0 1 - v/length(phi)])
plot3(phi(5,v:v+t_span-1), phi(1,v:v+t_span-1), label(1,v:v+t_span-1))
end

% surface(X,Y,Z,'FaceAlpha',0.8,'LineStyle','none')
surface(X,Y,U,'FaceAlpha',0.8,'LineStyle','none')
v = 83;
plot3(phi(5,v:v+t_span-1), phi(1,v:v+t_span-1), label(1,v:v+t_span-1),'k','LineWidth',3)

hold off
xlabel('Time')
ylabel('$x_1$')
zlabel('$x_2$')
% view([-0 8])
% view([62 -4])
view([45 27])

end

