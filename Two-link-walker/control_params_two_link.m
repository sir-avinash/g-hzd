function [th1d,alpha,epsilon,dth1d]=control_params_two_link
%control_params_two_link.m
%
%   Control parameters for two-link legged biped.
%
% This file is associated with the book Feedback Control of Dynamic 
% Bipedal Robot Locomotion by Eric R. Westervelt, Jessy W. Grizzle, 
% Christine Chevallereau, Jun-Ho Choi, and Benjamin Morris published 
% by Taylor & Francis/CRC Press in 2007.
% 
% Copyright (c) 2007 by Eric R. Westervelt, Jessy W. Grizzle, Christine
% Chevallereau, Jun-Ho Choi, and Benjamin Morris.  This code may be
% freely used for noncommercial ends.  If use of this code in part or in
% whole results in publication, proper citation must be included in that
% publication.  This code comes with no guarantees or support.
% 
% Eric Westervelt
% 20 February 2007

th1d=pi/15;  % impact occurs with walking surface
dth1d = 1.2;
alpha=0.95;  % see page 14 of Grizzle paper
epsilon=0.12; % see page 16 of Grizzle paper