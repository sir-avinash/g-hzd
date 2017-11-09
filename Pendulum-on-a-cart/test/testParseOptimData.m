clear
d_xSet = assignDelta();
date = '09-Feb-2017';
u = [];
x = [];
for n = 1:length(d_xSet)
% 	n = 1;
	vers = ['_d',num2str(n)];
	d = load(['DataFiles\17-02-09\','Response',date,vers]);
	
	u(n,1) = d.response.inputs{1}(1);
	x(n,:) = d.response.states{1}(:,1)';
end
	
%%
nnFit

%%
figure(1)
plot(1:length(u), [u, y])