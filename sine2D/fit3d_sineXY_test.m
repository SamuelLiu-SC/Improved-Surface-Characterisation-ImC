clear all
close all

%% measured 
xystep = 1.47489e-006 * 1000;

test_data = read_zygo_data_3B('20.xyz', 1024, 1024, xystep);
display_xyz_data_v3( test_data, 1, 0 );
axis normal

[ test_data ] = cut_data_3d_B( test_data, 800, 1600, 400, 1100, 0, 0 );

display_xyz_data_v3( test_data, 1, 0 );
axis equal

[ test_data2 ] = normalize_data_3d_v3_minmax( test_data );
display_xyz_data_v3( test_data2, 1, 0 );
axis equal
		zlabel('z/�m'); 
		xlabel('x/�m'); 
		ylabel('y/�m'); 
		ax = colorbar;		
		ylabel(ax, 'z/�m');

%% simulation
x = -600:5:600;
y = -600:5:600;
scale1 = 1.3*2;
scale2 = 1.3*2;
sx = 400;
sy = 400;
[xyz] = generate_sinsin_surface_xyz(x, y, scale1, scale2, sx, sy);

display_xyz_data_v3( xyz, 1, 1 )
axis equal
		zlabel('z/�m'); 
		xlabel('x/�m'); 
		ylabel('y/�m'); 
		ax = colorbar;		
		ylabel(ax, 'z/�m');
        
%% fitting
initial = [0, 0, 0,    0, 0, pi/4,                      scale1, scale2, sx, sy            ];
lb = [-200, -200, -2,    -0.5, -0.5, pi/4 - pi/8,       scale1-0.2, scale2-0.2, sx-100, sy-100          ];
ub = [200, 200, 2,       0.5, 0.5, pi/4 + pi/8,         scale1+0.2, scale2+0.2, sx+100, sy+100             ];

tic
[fit_scale1, fit_scale2, fit_sx, fit_sy, X, Dr, Mr, ErrMap, data_nor, xyc_nor] = fit3d_sineXY_v2_returnDDMMERR(test_data2, x, y, initial, lb, ub); 
toc



legend('Fitted','Measured','Location','NorthWest');
		zlabel('z/�m'); 
		xlabel('x/�m'); 
		ylabel('y/�m'); 
