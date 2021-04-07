function  img=huff_decode(des_img,coding,bit_len,dicts,N,M)
    img=zeros(N*M,1);
    cur_code=zeros(1,64);
    ind=0;
    mult=8;
    size_col=2;
    sym_size=size(dicts,1);
    cur_pix=1;
    
    %first find list of sizes of codes
    num_sizes=0;
    code_sizes=zeros(size(des_img,1)*size(des_img,2),1);
    for d=1:sym_size
        if ismember(dicts(d,size_col),code_sizes)==0
            num_sizes=num_sizes+1;
            code_sizes(num_sizes)=dicts(d,size_col);
        end
    end
    code_sizes=sort(code_sizes);
    min_len=code_sizes(1);
    
    
    %for each bit in stream
    for i=1:bit_len
        ind=ind+1;
        cur_int=ceil(i/mult);
        cur_shift=mod(i,mult);
        if cur_shift==0
            cur_shift=mult;
        end
        cur_code(ind)=bitget(coding(cur_int),cur_shift);
        
        if ind>=min_len
            for d=1:sym_size
                if dicts(d,size_col)==ind
                    diff=dicts(d,size_col+1:size_col+ind)-cur_code(1:ind);
                    if sum(diff~=0)==0
                        img(cur_pix)=dicts(d,1);
                        cur_code=zeros(1,64);
                        ind=0;
                        cur_pix=cur_pix+1;
                        break;
                    end
                end
            end
        end
    end
    img=img(1:N*M);
    img=reshape(img,N,M);
    img=uint8(img);
end