function [fit_x1, fit_x2, fit_height, X, Dr, Mr, ErrMap, data_nor, xyc_nor] = fit3d_blaze_grating_v2_returnMMDDERR(data, xlen, ylen, maxdis, initial, lb, ub)


global gxlen
global gylen
global gmaxdis
% global gyres
global gdata
global gdata_design
global gcnt

global DD
global MM

[ data_nor ] = normalize_data_3d_v3_minmax( data );

gxlen = xlen;
gylen = ylen;
gmaxdis = maxdis;
% gyres = yres;

gdata = data_nor;

cnt = 0;
gcnt = cnt;

x1 = initial(1);
x2 = initial(2);
height = initial(3);

ifdisplay = 0;
[xx, yy, zz, xyz] = ...
    generate_blaze_grating_maxdis(xlen, ylen, x1, x2, maxdis, height, ifdisplay);

[ xyc_nor ] = normalize_data_3d_v3_minmax( xyz );
[ xyc_nords ] = downsampling_random_xyz( xyc_nor, 10 );

gdata_design = xyc_nords;

figure
hold on
plot3(gdata_design(:,1), gdata_design(:,2), gdata_design(:,3), 'r.');
plot3(gdata(:,1), gdata(:,2), gdata(:,3), 'b.');


options = optimoptions('fmincon','Display','iter','PlotFcn',@optimplotfval);
options.Algorithm = 'interior-point';
options.MaxFunctionEvaluations = 500;
options.MaxIterations = 50;
Tolerance = 1.000000000000000e-12;
options.FunctionTolerance = Tolerance;
options.OptimalityTolerance = Tolerance;
options.StepTolerance = Tolerance;

x0 = initial;

%                               A   b   Aeq beq   lb  ub      nonlcon
[X, fval] = fmincon(@fit3d_blaze_grating_fun, x0,   [], [], [], [],   lb, ub, [],       options);


fit_x1 = X(1);
fit_x2 = X(2);
fit_height = X(3);

Tx = X(4);
Ty = X(5);
Tz = X(6);
rx = X(7);
ry = X(8);
rz = X(9);

ifdisplay = 1;
[xx, yy, zz, xyz] = ...
    generate_blaze_grating_maxdis(xlen, ylen, fit_x1, fit_x2, maxdis, fit_height, ifdisplay);

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