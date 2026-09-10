
clear all
close all

%% measured
xystep = 1.47489e-006*1000;

test_data = read_zygo_data_3B('sing_5.5x1_test.xyz', 1024, 1024, xystep);
display_xyz_data_v3( test_data, 1, 0 );
axis normal

[ test_data ] = cut_data_3d_B( test_data, 270, 1250, 270, 1250, 0, 0 );

display_xyz_data_v3( test_data, 1, 0 );
axis normal

%% simulation
R = 1400;
d = 200;
res_xy = 2;
len_xy = 250;
num_x = 4;
num_y = 4;

xyz = generate_microlens_group(R, d, res_xy, len_xy, num_x, num_y);

[ pointsnum ] = display_xyz_data_v2( xyz, 1 );
axis normal

%% normalise
[ test_data2 ] = normalize_data_3d_v3_minmax( test_data );
[ xyz2 ] = normalize_data_3d_v3_minmax( xyz );
[ pointsnum ] = display_xyz_data_v2( xyz2, 1 );
axis normal
[ pointsnum ] = display_xyz_data_v2( test_data2, 1 );
axis normal


%% fitting, find R, d, len_xy 

initial = [0, 0, 0,    0, 0, 0,             1200, 200, 250            ];
lb = [-20, -10, -1,    -0.5, -0.5, -0.5,    1000, 180, 200          ];
ub = [20, 10, 1,       0.5, 0.5, 0.5,       1400, 220, 300             ];

tic
[fit_R, fit_d, len_xy, X, Dr, Mr, ErrMap, data_nor, xyc_nor] = fit3d_lensArray_v2_returnDDMMERR(test_data2, res_xy, num_x, num_y, initial, lb, ub); 
toc



legend('Fitted','Measured','Location','NorthWest');
		zlabel('z/�m'); 
		xlabel('x/�m'); 
		ylabel('y/�m'); 

