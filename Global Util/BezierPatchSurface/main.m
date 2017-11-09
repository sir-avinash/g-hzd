% clc, close all, clear all

load('teapot'); %loading matrix S
% % Matrix S stores all the control points of all the patches of
% % teapot surface such that
% % S(:,:,:,k) control points of kth patch, where k=1..32
% % Size of S(:,:,:,k) is 4 x 4 x 3, i.e., 16 control points and each
% % control point has three values (x,y,z)

% % S(:,:,1,k): x-coordates of control points of kth patch as 4 x 4 matrix 
% % S(:,:,2,k): y-coordates of control points of kth patch as 4 x 4 matrix 
% % S(:,:,3,k): z-coordates of control points of kth patch as 4 x 4 matrix
% % ------------------------------------
[r c d np]=size(S);
% S(:,:,1,:) = repmat(ones(4),1,1,1,32);
% % np: number of patches
ni=20; %number of interpolated values between end control points
u=linspace(0,1,ni); v=u;  %uniform parameterization
% % Higher the value of ni smoother the surface but computationally
% % expensive
% % ------------------------------------
% % Cubic Bezier interpolation of control points of each patch
S = [
    2.5000    2.4000    2.3000    2.4000	2.3000
    2.5313    2.6313    2.5313    2.5313	2.5313
    2.5313    2.3313    2.5313    2.5313    2.5313
    2.2000    2.4000    2.8000    2.4000	2.8000
	2.2000    2.4000    2.8000    2.4000	2.8000
];
Q=bezierpatchinterp(S,u,v); %interpolation of kth patch

% % ------------------------------------
% % Plotting a signle Bezier Patch in many ways
k=11; %ploting kth patch
% plotbezierpatch3D(S(:,:,:,k),Q(:,:,:,k))

%%
[X, Y] = meshgrid(u, v);
figure(1);clf
% surface(Q(:,:,1,k),Q(:,:,2,k),Q(:,:,3,k),'FaceColor','green')
surface(X,Y,Q,'FaceColor','interp');
view([-28 28])
%%
% % Plotting Bezier surface (all the patches) in many ways
plotbeziersurface3D(s,Q(:,:,:,k))
% % --------------------------------
% % This program or any other program(s) supplied with it does not provide any
% % warranty direct or implied.
% % This program is free to use/share for non-commerical purpose only. 
% % Kindly reference the author.
% % Author: Dr. Murtaza Khan
% % URL : http://www.linkedin.com/pub/dr-murtaza-khan/19/680/3b3
% % --------------------------------
