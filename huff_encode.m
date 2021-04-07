function [coding,bit_len]=huff_encode(img,dicts)
    si=size(img,1);
    mult=8;
    N=64*size(img,1)/mult;%using bit shifting so div by 8
    coding=uint8(zeros(1,N));
    ind=1;
    size_col=2;%col 1 is symbol, col 2 is size, rest is code
    
    %for each pixel in image
    for i=1:si
        %get the value
        pix_val=img(i);
        %for each bit in the code for that pixel
        for j=size_col+1:dicts(pix_val+1,size_col)+size_col
            %add that bit to the stream (need to do some bitshift math)
            cur_int=ceil(ind/mult);
            cur_shift=mod(ind,mult);
            if cur_shift==0
                cur_shift=mult;
            end
            coding(cur_int)=bitset(coding(cur_int),cur_shift,dicts(pix_val+1,j));
            ind=ind+1;
        end
    end
    bit_len=ind;
    coding=coding(1:ceil(bit_len/mult));
end