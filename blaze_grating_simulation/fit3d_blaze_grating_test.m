

close all
clear all


%% simulated 
xlen = 15;
ylen = 15;
x1 = 0.3-0.1;
x2 = 3+0.1;
maxdis = 0.05;
height = 0.25-0.01;
ifdisplay = 1;

[xx, yy, zz, xyz] = ...
    generate_blaze_grating_maxdis(xlen, ylen, x1, x2, maxdis, height, ifdisplay);


[ xyzn ] = convert_mesh_to_xyz( xx, yy, zz );

display_3d_color(xx, yy, zz, '', 'x', 'y', 'z');

[ xyznt ] = transform_3DMatrix_xyz_v2( xyzn, 0.1, 0.1, 0.1, 0.05, 0.05, 0.05 );

[ pointsnum ] = display_xyz_data_v2( xyznt, 1 );

%% fitting

initial = [x1-0.05, x2-0.2, height-0.05, 0, 0, 0, 0, 0, 0];
del_x1 = 0.2;
del_x2 = 0.5;
del_height = 0.1;
lb = [x1-del_x1, x2-del_x2, height-del_height, -1, -1, -0.5,  -0.1, -0.1, -0.1];
ub = [x1+del_x1, x2+del_x2, height+del_height, 1, 1, 0.5,     0.1, 0.1, 0.1];

test_data = xyznt;
downs = 10;
[ test_datads ] = downsampling_random_xyz( test_data, downs );
display_xyz_data_no_fig_style( test_datads, 2, 1, 0, 'r.')

tic
[fit_x1, fit_x2, fit_height, X, Dr, Mr, ErrMap, data_nor, xyc_nor] = fit3d_blaze_grating_v2_returnMMDDERR(test_datads, xlen+5, ylen+5, maxdis, initial, lb, ub);
toc

%% result 
result = [fit_x1, fit_x2, fit_height]


legend('Fitted','Measured','Location','NorthWest');
		zlabel('z/�m'); 
		xlabel('x/�m'); 
		ylabel('y/�m'); 
