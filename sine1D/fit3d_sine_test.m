
clear all
close all

test_data = load('543.txt');
display_xyz_data_v3( test_data, 1, 0 );
axis normal

xstart = 0;
xend = 14;
ystart = 0;
yend = 14;
res = 0.05;
initial = [0.12, 2.5, 0, 0, 0, 0, 0, 0];
lb = [0.10, 2.0, -2, -1, -0.1,  -0.1, -0.1, -0.1];
ub = [0.15, 3.0, 2, 1, 0.1,     0.1, 0.1, 0.1];

tic 
[height, single_len, X, Dr, Mr, ErrMap, ms_nor, ds_nor] = fit3d_sine_v2_returnMMDDErr(test_data, xstart, xend, ystart, yend, res, initial, lb, ub); 
toc



legend('Fitted','Measured','Location','NorthWest');
		zlabel('z/�m'); 
		xlabel('x/�m'); 
		ylabel('y/�m'); 
