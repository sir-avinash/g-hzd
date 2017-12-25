function outputs = gen_points(sym_list, str_list)
    remain = str_list ;
    delim = ' ' ;
    k = 0 ;
    for j=1:length(str_list)
        if(str_list(j) == delim)
            k = k + 1 ;
        end
    end
    no_elem = k + 1 ;
    sz = size(sym_list,2) / no_elem ;
    for j=1:no_elem
        [tok remain] = strtok(remain, delim) ;
        outputs{j,1} = sym_list(:,1+(j-1)*sz:j*sz) ;
        outputs{j,2} = tok ;
    end
end