function get_jpg_compresion(img_name)
    img=imread(img_name);
    not_compressed=size(img,1)*size(img,2);
    s=dir(img_name);
    compressed=s.bytes;
    figure
    imshow(img_name)
    title(img_name+"Lossy JPEG Compression")
    fprintf("Actual JPEG Compression Ratio: %f%%\n\n",compressed/not_compressed*100)
end
