% % Function to interpolate 16 control points of a Bezier patch.

% % -> A Bezier patch is defined by 16 control points 
% % -> Cotrol points are arranged as (4 x 4 x dim) matrix. 
% % -> dim is the dimension, e.g., for 3D a control point
% %    has three coordinates (x,y,z)

% % Details
% % -> Input Matrix P stores 16 control points of a patches
% % -> Size of P is 4 x 4 x dim 
% % -> P(:,:,k) holds control points of kth dimension
% % -> Size of P(:,:,k) is 4 x 4 i.e., 16 control points.
% % -> For example for 3D (dim=3, k=1..3) size of P(:,:,k) is 4 x 4 x 3 
% %    i.e., 16 control points for in each dimension
% %    P(:,:,1): x-coordates of control points as 4 x 4 matrix 
% %    P(:,:,2): y-coordates of control points as 4 x 4 matrix 
% %    P(:,:,3): z-coordates of control points as 4 x 4 matrix
% % -> Output matrix Q stores interpolated values between control points
% %    Q is similar to P in format but has more values, i.e., it stores 
% %    end control points and interpolated values. 

% % -> u, v and optional argments that specify number of interpolated
% %    points between control points. Default values of u and v are 101

function Q=bezierpatchinterp(P,varargin)

%%% Default Values %%%
u=linspace(0,1,101); % uniform parameterization 
v=u;
defaultValues = {u,v};
%%% Assign Valus %%%
nonemptyIdx = ~cellfun('isempty',varargin);
defaultValues(nonemptyIdx) = varargin(nonemptyIdx);
[u,v] = deal(defaultValues{:});
% % --------------------------------
Q=[];

[r c dim]=size(P);

if r ~= c
	error('Not squre matrix parameters')
end

if r == 4
M = [
-1 3 -3 1
3 -6 3 0
-3 3 0 0
1 0 0 0
    ];

elseif r == 5
	M = [
	1 -4 6 -4 1
	-4 12 -12 4 0
	6 -12 6 0 0
	-4 4 0 0 0
	1 0 0 0 0
    ];
	
elseif r == 6
M = [
	-1   5   -10 10 -5 1
	5   -20   30 -20 5 0
	-10  30  -30 10 0 0
	10  -20  10 0 0 0
	-5   5    0 0 0 0
	1    0    0 0 0 0
    ];
	
elseif r == 7
	M = [
	1 -6 15 -20 15 -6  1
	-6 30 -60 60 -30 6 0
	15 -60 90 -60 15 0 0
	-20 60 -60 20 0  0 0
	15 -30 15 0   0  0 0 
	-6  6   0 0   0  0 0
	1   0   0 0   0  0 0 
	];

else
	error('Undefined parameters length')
end


MT = M'; % transform of matrix M

for i = 1:length(u)
    for j = 1:length(v)
%         U  = [1 u(i) u(i)^2 u(i)^3];
%         VT = [1 v(j) v(j)^2 v(j)^3]'; 
		
		U  = [u(i)^4 u(i)^3 u(i)^2 u(i) 1];
        VT = [v(j)^4 v(j)^3 v(j)^2 v(j) 1]'; 
		
        for k = 1:dim % interpolation for each dimension of control points
            Q(i,j,k) = U * M * P(:,:,k) * MT * VT;
        end         
    end    
end

% % --------------------------------
% % This program or any other program(s) supplied with it does not provide any
% % warranty direct or implied.
% % This program is free to use/share for non-commerical purpose only. 
% % Kindly reference the author.
% % Author: Dr. Murtaza Khan
% % URL : http://www.linkedin.com/pub/dr-murtaza-khan/19/680/3b3
% % --------------------------------


