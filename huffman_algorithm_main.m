clear all;close all;

perform_huffman("image_folder/lena.bmp");
get_jpg_compresion("image_folder/jpegs/lena.jpg");

perform_huffman("image_folder/checkers.bmp");
get_jpg_compresion("image_folder/jpegs/checkers.jpg");

perform_huffman("image_folder/monotone_disk.bmp");
get_jpg_compresion("image_folder/jpegs/monotone_disk.jpg");

perform_huffman("image_folder/ball_shading_large.bmp");
get_jpg_compresion("image_folder/jpegs/ball_shading_large.jpg");

perform_huffman("image_folder/swamp_large.bmp");
get_jpg_compresion("image_folder/jpegs/swamp_large.jpg");





