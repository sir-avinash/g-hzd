function write_fcn_c(fcn_name,inputs,replace_list,outputs)

%--------------------------------------------------------------------------
% Writes a function in C
%   write_fcn_c(fcn_name, inputs, replace_list, outputs)
%   fcn_name    A character string denoting the name of the function we are writing
%   inputs      A two column list of the input parameters with the fist
%       column being the data type and the second the variable name.
%   replace_list    A two column matrix of strings with the first column
%       containing the string to replace with the string in the second
%       column.
%   outputs     A three column list of the output parameters with the first
%       column containing the variable, the second its c variable type, and
%       the third its name.
%--------------------------------------------------------------------------


    % validate output variable names - Has to be valid in maple
    outputs = validate_output_names(outputs) ;
    
    % Get Input var declarations
    inputs_text = deduce_input_type(inputs, replace_list) ;
    
    % Get Output var declarations
    outputs_text = deduce_output_type(outputs) ;
    
    % Longest length strings first. - TODO: REPLACEMENT SHOULD BE BASED ON TOKENS.
    replace_list = bubble_sort_length(replace_list) ;

    % Open relevant files for writing
    [path name fid fid_h fid_mex] = open_files(fcn_name) ;

    % Get fcn prototype
    fcn_prototype = get_fcn_prototype(name, {inputs_text{:,1}}, {outputs_text{:,1}}) ;
    
    % write header file
    write_header_file(fid_h, name, fcn_prototype) ;
    fclose(fid_h) ;
    
    % write mex file
    write_mex_file(fid_mex, path, name, inputs, outputs, inputs_text, outputs_text) ;
    fclose(fid_mex) ;
  
    
    % write cpp file
    fprintf(fid, '%s\n\n', ['#include "' name '.h"']) ;
    fprintf(fid,fcn_prototype) ;
    fprintf(fid,'\n{\n') ;
    for i=1:1:length(replace_list) % write temporaries
        fprintf(fid,'  double %s = %s;\n',char(replace_list(i,1)),char(replace_list(i,2)));
    end
    fprintf(fid,'\n');

    declare_list = {}; % list of temporaries declared.
    % write variables computations to temporary file
    fid_tem = fopen('temp.tmp','w');
    for item = 1:1:size(outputs,1)
        currentvar = outputs{item,1};
        currentname = outputs{item,2};
        list_tem = cc(fid_tem,currentvar,currentname);
        declare_list = [declare_list;list_tem];
    end
    fclose(fid_tem);

    % remove duplicates in list of temporaries declared, and write
    % temporary variable definitions
    declare_list=sort(declare_list);
    unique=ones(size(declare_list,1),1);
    for i=1:1:size(declare_list,1)-1
        if (strcmp(char(declare_list(i)),char(declare_list(i+1))))
            unique(i) = 0;
        end
    end
    declare_list = declare_list(unique == 1);
    for i=1:1:size(declare_list,1)
        fprintf(fid,'  double %s;\n',char(declare_list(i)));
    end
    fprintf(fid,'\n');

    % copy code from temporary file to cpp file
    fid_tem = fopen('temp.tmp','r');
    while(1)
        line = fgetl(fid_tem);
        if ~ischar(line), break, end
        fprintf(fid,'%s\n',line);
    end
    fprintf(fid, '  return;\n}\n\n');
    fclose(fid_tem); delete('temp.tmp');
    fclose(fid);
end


%=============================================
function [str] = replace(str,replace_list)
  replaced = zeros(size(str));
  for i=size(replace_list,1):-1:1
    orig_str = char(replace_list(i,1));
    new_str = char(replace_list(i,2));
    t = findstr(str,orig_str);
    while(any(t))
      ok = 1;
      for i=t(1):1:t(1)+length(orig_str)-1
        if (replaced(i) == 1)
          ok = 0;
        end
      end
      if (ok == 1)
        str = [str(1:t(1)-1), new_str, str(t(1)+length(orig_str):end)];
        replaced = [replaced(1:t(1)-1), ones(size(new_str)),replaced(t(1)+length(orig_str):end)];
        t = t(2:end) + ones(size(t(2:end)))*(length(new_str)-length(orig_str));
      else
        t = t(2:end);
      end
    end
  end
end
%==================================================================

function [declare_list] = cc(fid,var,name)

  if(isnumeric(var))
      str = num2str(var) ;
  else
    str = char(var);
  end

  if (length(findstr(str,'matrix'))==0)
    str = ['matrix([[', str, ']])'];
  end

  c = optimized_ccode(name,str);

  % string replacements necessary for correct syntax
  
  if(size(var,1)==1 && size(var,2)==1) % scalar
      c = regexprep(c, [name '\[\d+\]\[\d+\]'], name) ;
  elseif(size(var,1)==1) % vector transpose
      c = regexprep(c, [name '\[\d+\](\[\d+\])'], [name '$1']) ;
  elseif(size(var,2)==1) % vector
      c = regexprep(c, [name '(\[\d+\])\[\d+\]'], [name '$1']) ;
  else % matrix
      ; % do nothing
  end

  c = strrep(c,' ','');
  c = strrep(c,'~','');
  c = strrep(c,'][',',');
  c = strrep(c,'[','(');c = strrep(c,']',')');
  %c = strrep(c,name,['(*',name,')']);
  I = findstr(c,';');
  I = [0 I];

  declare_list = {};
  for i=1:1:length(I)-1
    if (length(findstr(c(I(i)+1:I(i+1)),name))==0)
      fprintf(fid,'  %s\n',c(I(i)+1:I(i+1)));
      tem=findstr(c(I(i)+1:I(i+1)),'=');
      declare_list=[declare_list;{c(I(i)+1:I(i)+tem-1)}];
    else
      fprintf(fid,'  %s\n',c(I(i)+1:I(i+1)));
    end
  end

  fprintf(fid,'\n\n');
end

  function K = fixlength(s1,s2,len,indent)

  %FIXLENGTH Returns a string which has been divided up into < LEN
  %character chuncks with the '...' line divide appended at the end%of each chunck.
  %   FIXLENGTH(S1,S2,L) is string S1 with string S2 used as break points into
  %   chuncks less than length L.
  %Eric Westervelt
  %5/31/00%1/11/01 - updated to use more than one dividing string
  %4/29/01 - updated to allow for an indent

  tmp=s1;
  K=[];
  count=0;
  while length(tmp) > len,
    I = [];
    for c = 1:length(s2)
      I = [I findstr(tmp,s2(c))];
      I = sort(I);
    end
    if isempty(I) & count == 0
      K = [];
      error('S2 does not exist in S1')
    end
    II = find(I <= len);
    if isempty(II)
      K = [];
      error('Cannot fixlength of S1 on basis of S2')
    end
    if nargin > 3
      K = [K,tmp(1:I(II(length(II)))),'',10,indent];
    else
      K = [K,tmp(1:I(II(length(II)))),'',10];
    end
    tmp = tmp(I(II(length(II)))+1:length(tmp));
    count = count+1;
  end
  K = [K,tmp];
  end

function c = optimized_ccode(name,str)
  maple([name ':=' str]);
  maple('using[codegen]:');
  c = maple(['codegen[C](' name ',optimized,precision=double);']);
  maple([name ':=''' name '''']);
end


% Deduce Input type from 'inputs' and 'replace_list'
% Input type is one of the following:
%  - scalar (No indexing in the replace_list)
%  - vector (Single indexing in the replace_list)
%  - matrix (Double indexing in the replace_list)
% c_vector, c_matrix are from the boost::numeric::ublas - Refer boost lib
function inputs_text = deduce_input_type(inputs, replace_list)
    inputs_text = {} ;
    for j = 1:length(inputs)
        if(sum( strcmp(replace_list(:,2), inputs{j}) ) == 1) % scalar
            inputs_text{j,1} = ['const double& ' inputs{j}] ;
            inputs_text{j,2} = 1 ;
        else
            elem_count = sum(cell2mat( regexp(replace_list(:,2), ['^' inputs{j} '\(\d+\)']) )) ;
            if(elem_count >= 1) % vector
                inputs_text{j,1} = ['const c_vector<double, ' num2str(elem_count) '>& ' inputs{j}] ;
                inputs_text{j,2} = elem_count ;
            else
                elem_count = sum(cell2mat( regexp(replace_list(:,2), ['^' inputs{j} '\(\s\d+\s,\s\d+\s\)']) )) ;
                if(elem_count >= 1) % matrix
                    col_count = sum(cell2mat( regexp(replace_list(:,2), ['^' inputs{j} '\(\s1\s,\s\d+\s\)']) )) ;
                    row_count = elem_count / col_count ;
                    inputs_text{j,1} = ['const c_matrix<double, ' num2str(row_count) ', ' num2str(col_count) '>& ' inputs{j}] ;
                    inputs_text{j,2} = [row_count col_count] ;
                else
                    disp('Error: unknown input type.') ; keyboard ;
                end
            end
        end
    end
end


% Deduce Output type from 'inputs' and 'replace_list'
% Input type is one of the following:
%  - scalar
%  - vector
%  - matrix
function outputs_text = deduce_output_type(outputs)
    outputs_text = {} ;
    for j = 1:size(outputs,1)
        sz = size(outputs{j,1}) ;
        if(sz(1) == 1 && sz(2) == 1) % scalar
            outputs_text{j,1} = ['double& ' outputs{j,2}] ;
            outputs_text{j,2} = 1 ;
        elseif(sz(1) == 1 || sz(2) == 1) % vector
            outputs_text{j,1} = ['c_vector<double, ' num2str(max(sz)) '>& ' outputs{j,2}] ;
            outputs_text{j,2} = max(sz) ;
        else % matrix
            outputs_text{j,1} = ['c_matrix<double, ' num2str(sz(1)) ', ' num2str(sz(2)) '>& ' outputs{j,2}] ;
            outputs_text{j,2} = sz ;
        end
    end
end


% process the longest strings first to keep from accidentally replacing substrings of longer strings
% perform a bubble sort on 'replace_list' according to decending length of the first element
% TODO: REPLACEMENT SHOULD BE BASED ON TOKENS. (In this case, the longest
% strings need not be first.)
function replace_list = bubble_sort_length(replace_list)
  for loop=1:1:size(replace_list,1)
    for i=1:1:size(replace_list,1)-1
      if (length(replace_list{i,1}) < length(replace_list{i+1,1}))
        temp = replace_list(i,:);
        replace_list(i,:) = replace_list(i+1,:);
        replace_list(i+1,:) = temp;
      end
    end
  end
end


% Function to open relevant files for writing
function [path name fid fid_h fid_mex] = open_files(fcn_name)
  [path, name, ext] = fileparts(fcn_name) ;
  if(~isempty(path))
      path = [path '\'] ;
  end
  disp(['- writing ' name ext]);
  
  % Open files
  fid = fopen(fcn_name,'w');
  fid_h = fopen([path name '.h'], 'w') ;
  fid_mex = fopen([path 'C' name '.cxx'], 'w') ;
end


% Function to get function prototype
function fcn_prototype = get_fcn_prototype(name, inputs_text, outputs_text)
  fcn_prototype = sprintf('void %s(', name) ;
  
  % write inputs
  for item = 1:length(inputs_text)
    if (item > 1)
        fcn_prototype = [fcn_prototype ', '] ;
    end
    fcn_prototype = [fcn_prototype inputs_text{item}] ;
  end

  % write outputs
  for item = 1:length(outputs_text)
    if (item > 1 || size(inputs_text,1) > 0)
      fcn_prototype = [fcn_prototype ', '] ;
    end
    fcn_prototype = [fcn_prototype outputs_text{item}] ;
  end
  
  fcn_prototype = [fcn_prototype ')'] ;
end


% Function to writeout header file
function write_header_file(fid_h, name, fcn_prototype)
  fprintf(fid_h, '%s\n', ['#ifndef _' name '_h_']) ; % Include directive
  fprintf(fid_h, '%s\n\n', ['#define _' name '_h_']) ;
  
  % Include appropriate header files
%  fprintf(fid_h, '%s\n\n', '#include "params.h"') ; % // For params
  fprintf(fid_h, '%s\n', '#include <boost/numeric/ublas/vector.hpp>') ; % // For c_vector
  fprintf(fid_h, '%s\n', '#include <boost/numeric/ublas/matrix.hpp>') ; % // For c_matrix

  % namespace
  fprintf(fid_h, '\n%s\n', 'using namespace boost::numeric::ublas ;') ;
  
  % fcn prototype
  fprintf(fid_h, '\n%s ;\n', fcn_prototype) ;
  
  % include directive
  fprintf(fid_h, '\n\n%s\n', ['#endif //_' name '_h_']) ;
end


% Function to check if output variable name is protected in maple. And
% modifiy name if so.
function outputs = validate_output_names(outputs)
    for item = 1:size(outputs,1)
        currentname = outputs{item,2};
        if(maple(['type(' currentname ', protected)'])) % append text to variable name if name protected in maple
            currentname = [currentname '_retval'] ;
            outputs{item,2} = currentname ;
        end
    end
end


% Function to writeout the mex file
function write_mex_file(fid_mex, path, name, inputs, outputs, inputs_text, outputs_text)
    fprintf(fid_mex, '#include <mex.h>\n') ;
    fprintf(fid_mex, '#include "%s.h"\n\n', name) ;
    fprintf(fid_mex, '%s\n{\n', 'void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])') ;
    
    fprintf(fid_mex, '\t/* Check for proper number of arguments. */\n') ;
    fprintf(fid_mex, '\tif(nlhs!=%d) mexErrMsgTxt("Incorrect no. of output arguments.");\n', size(outputs_text,1)) ;
    fprintf(fid_mex, '\tif(nrhs!=%d) mexErrMsgTxt("Incorrect no. of input arguments.");\n', size(inputs_text,1)) ;
       
    % Process inputs
    fprintf(fid_mex, '\n\n\t/* Process Inputs */') ;
    for j=1:size(inputs_text,1)
        fprintf(fid_mex, '\n') ;
        if(length(inputs_text{j,2})==1 && inputs_text{j,2}==1) % scalar
            fprintf(fid_mex, '\tif(mxGetM(prhs[%d])!=%d || mxGetN(prhs[%d])!=%d)\n',j-1,1,j-1,1) ;
            fprintf(fid_mex, '\t\tmexErrMsgTxt("Incorrect dimensions for input #%d - Should be scalar") ;\n',j) ;
            fprintf(fid_mex, '\tdouble %s = *(mxGetPr(prhs[%d]))\n', inputs{j}, j-1) ;
        elseif(length(inputs_text{j,2})==1) % vector
            M = inputs_text{j,2} ;
            fprintf(fid_mex, '\tif(!(mxGetM(prhs[%d])==%d && mxGetN(prhs[%d])==%d) && !(mxGetM(prhs[%d])==%d && mxGetN(prhs[%d])==%d) )\n', j-1,M,j-1,1,  j-1,1,j-1,M) ;
            fprintf(fid_mex, '\t\tmexErrMsgTxt("Incorrect dimensions for input #%d - Should be a vector of length %d") ;\n',j,M) ;
            fprintf(fid_mex, '\tc_vector<double, %d> %s ;\n', M, inputs{j}) ;
            fprintf(fid_mex, '\tfor(unsigned int i=0 ; i<%d ; ++i)\n', M) ;
            fprintf(fid_mex, '\t\t%s(i) = (mxGetPr(prhs[%d]))[i] ;\n', inputs{j},j-1) ;
        else % matrix
            sz = inputs_text{j,2} ; M = sz(1) ; N = sz(2) ;
            fprintf(fid_mex, '\tif(mxGetM(prhs[%d])!=%d || mxGetN(prhs[%d])!=%d)\n',j-1,M,j-1,N) ;
            fprintf(fid_mex, '\t\tmexErrMsgTxt("Incorrect dimensions for input #%d - Should be %d x %d") ;\n',j,M,N) ;
            fprintf(fid_mex, '\tc_matrix<double, %d, %d> %s ;\n', M, N, inputs{j}) ;
            fprintf(fid_mex, '\tfor(unsigned int i=0 ; i<%d ; ++i)\n', M) ;
            fprintf(fid_mex, '\t\tfor(unsigned int j=0 ; j<%d ; ++j)\n', N) ;
            fprintf(fid_mex, '\t\t\t%s(i,j) = (mxGetPr(prhs[%d]))[j*%d+i] ;\n', inputs{j},j-1, M) ;
        end
    end
    
    % Define output variables
    fprintf(fid_mex, '\n\n\t/* Define Output variables */\n') ;
    for j=1:size(outputs_text,1)
        sz = outputs_text{j,2} ;
        if(length(sz)==1 && sz==1) % scalar
            M = 1 ; N = 1 ;
            var_type = 'double' ;
        elseif(length(sz)==1) % vector
            M = sz ; N = 1 ;
            var_type = ['c_vector<double, ' num2str(M) '>'] ;
        else
            M = sz(1) ; N = sz(2) ;
            var_type = ['c_matrix<double, ' num2str(M) ', ' num2str(N) '>'] ;
        end
        
        fprintf(fid_mex, '\t%s %s ;\n', var_type, outputs{j,2}) ;
        fprintf(fid_mex, '\tplhs[%d] = mxCreateDoubleMatrix(%d,%d, mxREAL);\n', j-1,M,N) ;
    end
    
    % Invoke function
    fprintf(fid_mex, '\n\n\t/* Invoke function */\n') ;
    fcn_prototype = get_fcn_prototype(name, inputs, {outputs{:,2}}) ;
    tok = regexp(fcn_prototype, '^void (.*)', 'tokens') ;
    tok = tok{:} ;
    fprintf(fid_mex, '\t%s ;\n', tok{1}) ;
    
    % Process outputs
    fprintf(fid_mex, '\n\n\t/* Process Outputs */\n') ;
    for j=1:size(outputs_text,1)
        sz = outputs_text{j,2} ;
        if(length(sz)==1 && sz==1) % scalar
            fprintf(fid_mex, '\t*(mxGetPr(plhs[%d])) = %s ;\n', j-1,outputs{j,2}) ;
        elseif(length(sz)==1) % vector
            M = sz ;
            fprintf(fid_mex, '\tfor(unsigned int i=0 ; i<%d ; ++i)\n',M) ;
            fprintf(fid_mex, '\t\t(mxGetPr(plhs[%d]))[i] = %s(i) ;\n', j-1,outputs{j,2}) ;
        else
            M = sz(1) ; N = sz(2) ;
            fprintf(fid_mex, '\tfor(unsigned int i=0 ; i<%d ; ++i)\n',M) ;
            fprintf(fid_mex, '\t\tfor(unsigned int j=0 ; j<%d ; ++j)\n', N) ;
            fprintf(fid_mex, '\t\t\t(mxGetPr(plhs[%d]))[j*%d+i] = %s(i,j) ;\n', j-1,M,outputs{j,2}) ;
        end
    end
    
    fprintf(fid_mex, '}\n') ;
end