clear


folderDate = '17-09-08';	% Back stepping
DataSet = load(['DataSet_',folderDate]);
m = 11;
J_set = [];
next_state = [];
for n = 1:length(DataSet.d_xSet)

	vers = ['_b',num2str(n),'_o',num2str(m)];	% Back stepping
	
	% dropout infeasible initial condition		
	data = load(['DataFiles\',folderDate,'\Response_',folderDate,vers]);

	J_set(n) = data.J;
	[tStar, xStar, uStar, mStar] = data.response.unpack;
	next_state(:,n) = xStar{1}(:,41);
end		% for n

% feature = DataSet.d_xSet';
a = DataSet.d_xSet(1,:)';
b = DataSet.d_xSet(2,:)';
c = DataSet.d_xSet(3,:)';
d = DataSet.d_xSet(4,:)';
init_state = [a b c d]';

label = J_set(:);
feature = [a.^2 b.^2 c.^2 d.^2 a.*b a.*c a.*d b.*c b.*d c.*d ones(size(a))];

%%
% [Mdl,FitInfo] = fitrlinear(feature,label);
% w = Mdl.Beta;
w = feature\label;
label_train = feature*w;

correlation_coeff = corr2(label,label_train);

r_sqr = power(correlation_coeff,2);
%%
figure(10);clf
plot(label)
hold on
plot(label_train)
hold off

%%

P = [w(1) w(5)/2 w(6)/2 w(7)/2
	 w(5)/2 w(2) w(8)/2 w(9)/2 
	 w(6)/2 w(8)/2 w(3) w(10)/2
     w(7)/2 w(9)/2 w(10)/2 w(4)];
P = P./norm(P)
eig(P)
%  P = [1 0; 0 1];
[r p] = chol(P)

%          0.04         -0.11          0.03         -0.03
%          -0.11          0.94         -0.12          0.18
%           0.03         -0.12          0.03         -0.03
%          -0.03          0.18         -0.03          0.04

%%	Evaluate the V function
V = @(x)x'*P*x;

V_init = [];
V_next = [];
for n = 1:length(init_state)
V_init(n,1) = V(init_state(:,n));
V_next(n,1) = V(next_state(:,n));
end

figure(20)
plot(1:625, [V_init, V_next])

figure(30)
plot(1:625, [V_next./V_init],'o')
ax = gca;
xlim([1,625])
ax.XTick = linspace(1,625, 5);
xlabel('Sample Points')
ylabel('Function Ratio')
% ax.XTick ([-3*pi -2*pi -pi 0 pi 2*pi 3*pi])










