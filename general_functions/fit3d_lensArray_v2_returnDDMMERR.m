function [Rf, df, len_xyf, X, Dr, Mr, ErrMap, data_nor, xyc_nor] = fit3d_lensArray_v2_returnDDMMERR(data, res_xy, num_x, num_y, initial, lb, ub)
% fit best sine save using data 
% y = a*sin(bx) plus Tx, Ty, Rz 
% variables: a, b, Tx, Ty, Rz 

global gdata


global RES
global NUMX
global NUMY

global DD
global MM

RES = res_xy;
NUMX = num_x;
NUMY = num_y;

[ data_nor ] = normalize_data_3d_v3_minmax( data );
[ data_nords ] = downsampling_random_xyz( data, 50 );

gdata = data_nords;

R = initial(7);
d = initial(8);
len_xy = initial(9);

xyz = generate_microlens_group(R, d, res_xy, len_xy, num_x, num_y);
[ xyc_nor ] = normalize_data_3d_v3_minmax( xyz );
[ xyc_nords ] = downsampling_random_xyz( xyc_nor, 10 );

gdata_design = xyc_nords;

figure
hold on
plot3(gdata_design(:,1), gdata_design(:,2), gdata_design(:,3), 'r.');
plot3(gdata(:,1), gdata(:,2), gdata(:,3), 'b.');



options = optimoptions('fmincon','Display','iter','PlotFcn',@optimplotfval);
options.Algorithm = 'interior-point';
options.MaxFunctionEvaluations = 800;
options.MaxIterations = 80;
Tolerance = 1.000000000000000e-15;
options.FunctionTolerance = Tolerance;
options.OptimalityTolerance = Tolerance;
options.StepTolerance = Tolerance;
x0 = initial;

%                               A   b   Aeq beq   lb  ub      nonlcon
[X, fval] = fmincon(@fit3d_lensArray_fun, x0,   [], [], [], [],   lb, ub, [],       options);

Tx = X(1);
Ty = X(2);
Tz = X(3);
rx = X(4);
ry = X(5);
rz = X(6);

Rf = X(7);
df = X(8);
len_xyf = X(9);


xyz = generate_microlens_group(Rf, df, res_xy, len_xyf, num_x, num_y);
[ xyc_nor ] = normalize_data_3d_v3_minmax( xyz );

% model 
[ xyct ] = transform_3DMatrix_xyz_v2( xyc_nor, Tx, Ty, Tz, rx, ry, rz );

D = xyct;

MT = data_nords;

xyz_output = interpolation_3d_xyz(xyct, MT(:,[1 2]));
delta = xyz_output(:,3) - MT(:,3);
Err2=inpaint_nans(delta);
E = rms(Err2);


figure
plot3(MT(:,1), MT(:,2), Err2, '.')
title('err fitting');

ErrMap = [MT(:,1), MT(:,2), Err2];

D = D';
MT = MT';
figure,hold on; ms=2; lw=1; fs=12;
plot3(D(1,:),D(2,:),D(3,:),'.r','MarkerSize',ms,'LineWidth',lw);
plot3(MT(1,:),MT(2,:),MT(3,:),'xb','MarkerSize',ms,'LineWidth',lw);
legend('model','fitted template','Location','NorthWest');
set(gca,'FontSize',fs);
axis normal

DD = D;
MM = MT;

Dr = D';
Mr = MT';

end