% Function to generate the autogen vcproj, and the partial solution file
% Input Params
%  path - Path of C++ files
function genVCSoln(path, boost_path, matlab_include_path, matlab_link_path, mexversion_rc_path)
    if(nargin < 5)
        path = 'autogen\cpp\'
        boost_path = 'C:\Program Files\boost\boost_1_36_0' ;
        matlab_include_path = 'C:\Program Files (x86)\MATLAB\R2007a\extern\include' ;
        matlab_link_path = 'C:\Program Files (x86)\MATLAB\R2007a\extern\lib\win32\microsoft' ;
        mexversion_rc_path = 'C:\Program Files (x86)\MATLAB\R2007a\extern\include' ;
    end
        
    boost_path = strrep(boost_path, '\', '\\') ;
    matlab_include_path = strrep(matlab_include_path, '\', '\\') ;
    matlab_link_path = strrep(matlab_link_path, '\', '\\') ;
    mexversion_rc_path = relativepath(mexversion_rc_path, [cd '\' path]) ;
    mexversion_rc_path = strrep(mexversion_rc_path, '\', '\\') ;
    
    
    % Find list of header files in autogen
    filenames_cpp = dir([path '*.cpp']) ;
    filenames_h = dir([path '*.h']) ; % Could contain additional header files
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write out autogen project
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     cpp_file_list=''; h_file_list='';
     for j=1:length(filenames_cpp)
         filenames_cpp(j).name(end-3:end) = [] ; % wipe out extension
%         cpp_file_list = [cpp_file_list '\n<File RelativePath=".\\' filenames_cpp(j).name '.cpp"/>'] ;
     end
%     for j=1:length(filenames_h)
%         filenames_h(j).name(end-1:end) = [] ; % wipe out extension
%         h_file_list = [h_file_list '\n<File RelativePath=".\\' filenames_h(j).name '.h"/>'] ;
%     end
%     fid_tem_vc = fopen('autogenTemplate.vcproj','r');
%     fid_vc = fopen([path 'autogen.vcproj'], 'w') ;
%     match_expr = {'REPLACE_CPP_FILES_TEXT', 'REPLACE_HEADER_FILES_TEXT'} ;
%     replace_expr = {cpp_file_list, h_file_list} ;
%     while(1)
%         line = fgetl(fid_tem_vc);
%         if ~ischar(line), break, end
%         fprintf(fid_vc,'%s\n',regexprep(line, match_expr, replace_expr));
%     end
%     fclose(fid_vc) ;
%     fclose(fid_tem_vc) ;
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write Visual Studio Project Files
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for j=1:length(filenames_cpp)
        fid_tem_vc = fopen('mexTemplate.vcproj','r');
        fid_vc = fopen([path 'C' filenames_cpp(j).name '.vcproj'], 'w') ;
        match_expr = {'REPLACE_TEXT','REPLACE_GUID_TEXT','REPLACE_BOOST_PATH','REPLACE_MATLAB_INCLUDE_PATH','REPLACE_MATLAB_LINK_PATH','REPLACE_MEXVERSION_RC_PATH'} ; % Match the text "REPLACE_TEXT"
        filenames_cpp(j).guid_txt = upper(char(java.util.UUID.randomUUID)) ; % Generate project GUID
        replace_expr = {filenames_cpp(j).name, filenames_cpp(j).guid_txt, boost_path, matlab_include_path, matlab_link_path, [mexversion_rc_path 'mexversion.rc']} ;
        while(1)
            line = fgetl(fid_tem_vc);
            if ~ischar(line), break, end
            fprintf(fid_vc,'%s\n',regexprep(line, match_expr, replace_expr));
        end
        fclose(fid_vc) ;
        fclose(fid_tem_vc) ;

        % Write Module definition File
        fid_tem_mod = fopen([path filenames_cpp(j).name '.def'], 'w') ;
        fprintf(fid_tem_mod,'LIBRARY C%s.mexw32\nEXPORTS mexFunction', filenames_cpp(j).name) ;
        fclose(fid_tem_mod) ;
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Write out solution
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    proj_list_txt='' ; config_list_txt='' ; nested_list_txt='' ;
    for j=1:length(filenames_cpp) % Extract guid for each project
        guid_txt = ['{' filenames_cpp(j).guid_txt '}'] ;
        proj_list_txt = [proj_list_txt '\nProject("{8BC9CEB8-8B4A-11D0-8D11-00A0C91BC942}") = "C' filenames_cpp(j).name '", "C' filenames_cpp(j).name '.vcproj", "' guid_txt '"\nEndProject'] ;
        config_list_txt = [config_list_txt '\n\t\t' guid_txt '.Debug|Win32.ActiveCfg = Debug|Win32\n\t\t' guid_txt '.Debug|Win32.Build.0 = Debug|Win32\n\t\t' guid_txt '.Release|Win32.ActiveCfg = Release|Win32\n\t\t' guid_txt '.Release|Win32.Build.0 = Release|Win32'] ;
        nested_list_txt = [nested_list_txt '\n\t\t' guid_txt ' = {B2369BE3-E02F-474D-8D72-068B6E724D14}'] ;
    end
    
    fid_tem_sln = fopen('solnTemplate.sln','r');
    fid_sln = fopen([path 'SymbolicExpr.sln'], 'w') ;
    match_expr = {'REPLACE_PROJ_TEXT', 'REPLACE_CONFIG_TEXT', 'REPLACE_NESTED_TEXT'} ;
    replace_expr = {proj_list_txt, config_list_txt, nested_list_txt} ;
    while(1)
        line = fgetl(fid_tem_sln);
        if ~ischar(line), break, end
        fprintf(fid_sln,'%s\n',regexprep(line, match_expr, replace_expr));
    end
    fclose(fid_sln) ;
    fclose(fid_tem_sln) ;
end