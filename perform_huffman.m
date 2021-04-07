function perform_huffman(img_name)
fprintf("Current Image: %s\n",img_name);
tv=tic;

img=(imread(img_name));
if size(img,3)==3
    img=img(:,:,1);
end
[N_orig, M_orig] = size(img);
img = img(:);
[N, M] = size(img);
mult=8;
count = zeros(256,1);
for i = 1:N
 for j = 1:M
       count(img(i,j)+1)=count(img(i,j)+1)+1;
  end
end
prob = count/(M*N);
symbols = (0:255)';
init_time=toc(tv);
tv=tic;
dicts=get_huffcodes(symbols,prob);
create_dict_time=toc(tv);
tv=tic;
[coding,bit_len]=huff_encode(img,dicts);
encoding_time=toc(tv);
tv=tic;
new_img=huff_decode(img,coding,bit_len,dicts,N_orig,M_orig);
decoding_time=toc(tv);
figure
imshow(new_img)
title(img_name)

total_time=init_time+create_dict_time+encoding_time+decoding_time;
time_per_pix=total_time/(N*M);
compression_ratio=(bit_len+size(dicts,1)*size(dicts,2))/(N*M*mult);

fprintf("Time to initially read in image, and get probabilities of each: %f seconds\n",init_time)
fprintf("Time to create codes for each pixel value: %f seconds\n",create_dict_time)
fprintf("Time to encode the image: %f seconds\n",encoding_time)
fprintf("Time to decode the image: %f seconds\n",decoding_time)
fprintf("Time for all processing involved: %f seconds\n",total_time)
fprintf("Time to process one pixel: %f seconds\n",time_per_pix)

fprintf("The compressed image is %f%% the size of the original uncompressed image\n",compression_ratio*100)

% num_orig_bits=N*M*mult;
% normal_speed=40*10^6;%40mbps
% normal_bps=1/normal_speed;
% 
% % num_orig_bits*equal_bps=num_orig_bits*compression_ratio*(equal_bps+time_per_pix)
% % equal_bps=compression_ratio*equal_bps+compression_ratio*time_per_pix
% % equal_bps*(1-compression_ratio)=compression_ratio*time_per_pix
% equal_bps=compression_ratio*time_per_pix/(1-compression_ratio);
% fprintf("Maximum rate that speed sending with compression is equal to send without: %f bits/s\n",equal_bps)
% fprintf("OR (more reasonable comparison)\n")
% % num_orig_bits*normal_bps=num_orig_bits*compression_ratio*(normal_bps+equal_time_per_pix)
% % normal_bps/compression_ratio=normal_bps+equal_time_per_pix
% equal_time_per_pix=normal_bps/compression_ratio-normal_bps;
% fprintf("Maximum average time to code and decode a pixel at 40mbps to match speeds of compressed and uncompressed sending: %d s/pixel\n",equal_time_per_pix)

end