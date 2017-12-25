% Function to generate the C and Matlab lists given the vector
% Inputs:
%     vec: vector of symbolic variables
%     str_prefix: This string prefix is appended to each element of the list.
% Outputs:
%     c_list: This is the c list
%     m_list: This is the m list
%
% Example:
% dq=[dqLA_L;dqLS_L;dqT];
% [c_list m_list] = gen_c_m_lists(q, 'dq') ;
% Produces:
% c_list = {'dqLA_L','dq(0)'; 'dqLS_L','dq(1)'; 'dqT','dq(2)';}
% m_list = {{'dqLA_L','dq(1)'; 'dqLS_L','dq(2)'; 'dqT','dq(3)';}
function [c_list m_list] = gen_c_m_lists(vec, str_prefix)
    c_list = {} ; m_list = {} ;
    for j=1:length(vec)
        c_list{j,1} = char(vec(j)) ;
        c_list{j,2} = [str_prefix '(' num2str(j-1) ')'] ;
        m_list{j,1} = char(vec(j)) ;
        m_list{j,2} = [str_prefix '(' num2str(j) ')'] ;
    end
end