function gen_files(path)
if(nargin < 1)
  path = '..\ATRIAS-3D_SymbolicCode\' ;
end
    % Set various paths
    % Relative Paths
    m_path = [path 'autogen\m\'] ;
    c_path = [path 'autogen\cpp\'] ;
    % Absolute Paths
    boost_path = 'C:\Program Files\boost\boost_1_36_0' ;
    matlab_include_path = 'C:\Program Files\MATLAB\R2008a\extern\include' ;
    matlab_link_path = 'C:\Program Files\MATLAB\R2008a\extern\lib\win32\microsoft' ;
    mexversion_rc_path = 'C:\Program Files\MATLAB\R2008a\extern\include' ;

    % Create directories if they do not exist
    if(~exist(m_path, 'dir'))
        mkdir(m_path) ;
    end
    if(~exist(c_path, 'dir'))
        mkdir(c_path) ;
    end

    % Load symbolic data
    load([path 'Mat\TempSymbolicData']) ;

    % Usually writing these files can be at the same place where the symbolic
    % variables are developed.
    % Generate replacment lists for m and c files.
    [c_list_q m_list_q] = gen_c_m_lists(q, 'q') ;
    [c_list_dq m_list_dq] = gen_c_m_lists(dq, 'dq') ;

    % Write m files
    write_fcn_m([m_path 'fcn_Atrias_D.m'],{'q', 'dq'},[m_list_q;m_list_dq],{D,'D'});
    write_fcn_m([m_path 'fcn_Atrias_Cdq.m'],{'q', 'dq'},[m_list_q;m_list_dq],{Cdq,'Cdq'});
    write_fcn_m([m_path 'fcn_Atrias_G.m'],{'q', 'dq'},[m_list_q;m_list_dq],{G,'G'});
    write_fcn_m([m_path 'fcn_Atrias_B.m'],{'q', 'dq'},[m_list_q;m_list_dq],{B,'B'});

    % Write cpp files
    write_fcn_c([c_path 'fcn_Atrias_D.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{D,'D'});
    write_fcn_c([c_path 'fcn_Atrias_Cdq.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{Cdq,'Cdq'});
    write_fcn_c([c_path 'fcn_Atrias_G.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{G,'G'});
    write_fcn_c([c_path 'fcn_Atrias_B.cpp'],{'q', 'dq'},[c_list_q;c_list_dq],{B,'B'});

    % Method 1
    %genVCSoln(c_path, boost_path, matlab_include_path, matlab_link_path, mexversion_rc_path) ;

    % Method 2
    % Compile cpp files to mex
    % ASSUMES mex -setup has been run and a compiler choosen.
    filenames_cpp = dir([c_path '*.cpp']) ;
    for j=1:length(filenames_cpp)
        disp(['Compiling ' filenames_cpp(j).name]) ;
        eval_str = ['mex -I' '"' boost_path '"' ' ' c_path 'C' filenames_cpp(j).name(1:end-3) 'cxx' ' ' c_path filenames_cpp(j).name ' -outdir ' c_path] ;
        eval(eval_str) ;
    end

    % add all subdirectories to path
    addpath(genpath(cd)) ;

end