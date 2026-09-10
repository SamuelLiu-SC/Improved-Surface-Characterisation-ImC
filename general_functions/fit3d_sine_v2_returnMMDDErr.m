function [height, single_len, X, Dr, Mr, ErrMap, data_nor, xyc_nor] = fit3d_sine_v2_returnMMDDErr(data, xstart, xend, ystart, yend, res, initial, lb, ub)
% fit best sine save using data 
% y = a*sin(bx) plus Tx, Ty, Rz 
% variables: a, b, Tx, Ty, Rz 

global gxstart
global gxend
global gystart
global gyend
global gres
global gdata
global gdata_design
global gcnt

global DD
global MM


[ data_nor ] = normalize_data_3d_v3_minmax( data );
[ data_nords ] = downsampling_random_xyz( data_nor, 10 );

gxstart = xstart;
gxend = xend;
gystart = ystart;
gyend = yend;
gres = res;
gdata = data_nords;

cnt = 0;
gcnt = cnt;


height = initial(1);
single_len = initial(2);

xc = xstart:res:xend;
yc = ystart:res:yend;
[xx, yy] = meshgrid(xc, yc);
zz = 0.5*height*sin(2*pi*xx/single_len);
[ xyz ] = convert_mesh_to_xyz( xx, yy, zz );

[ xyc_nor ] = normalize_data_3d_v3_minmax( xyz );
[ xyc_nords ] = downsampling_random_xyz( xyc_nor, 20 );

gdata_design = xyc_nords;

figure
hold on
plot3(gdata_design(:,1), gdata_design(:,2), gdata_design(:,3), 'r.');
plot3(gdata(:,1), gdata(:,2), gdata(:,3), 'b.');

options = optimoptions('fmincon','Display','iter','PlotFcn',@optimplotfval);
options.Algorithm = 'interior-point';
options.MaxFunctionEvaluations = 300;
options.MaxIterations = 30;
Tolerance = 1.000000000000000e-12;
options.FunctionTolerance = Tolerance;
options.OptimalityTolerance = Tolerance;
options.StepTolerance = Tolerance;

x0 = initial;

%                               A   b   Aeq beq   lb  ub      nonlcon
[X, fval] = fmincon(@fit3d_sine_fun, x0,   [], [], [], [],   lb, ub, [],       options);

height = X(1);
single_len = X(2);
Tx = X(3);
Ty = X(4);
Tz = X(5);
rx = X(6);
ry = X(7);
rz = X(8);

xc = xstart:res:xend;
yc = ystart:res:yend;
[xx, yy] = meshgrid(xc, yc);
zz = 0.5*height*sin(2*pi*xx/single_len);
[ xyz ] = convert_mesh_to_xyz( xx, yy, zz );

[ xyc_nor ] = normalize_data_3d_v3_minmax( xyz );


% model 
[ xyct ] = transform_3DMatrix_xyz_v2( xyc_nor, Tx, Ty, Tz, rx, ry, rz );

D = xyct;

MT = data_nor;

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