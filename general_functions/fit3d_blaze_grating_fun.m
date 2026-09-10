function [E] = fit3d_blaze_grating_fun( x )
% evaluate the ERR

global gxlen
global gylen
global gmaxdis
% global gyres
global gdata
% global gdata_design
global gcnt


x1 = x(1);
x2 = x(2);
height = x(3);

Tx = x(4);
Ty = x(5);
Tz = x(6);
rx = x(7);
ry = x(8);
rz = x(9);


xlen = gxlen;
ylen = gylen;
maxdis = gmaxdis;


ifdisplay = 0;
[xx, yy, zz, xyz] = ...
    generate_blaze_grating_maxdis(xlen, ylen, x1, x2, maxdis, height, ifdisplay);

[ xyc_nor ] = normalize_data_3d_v3_minmax( xyz );

% model 
[ xyct ] = transform_3DMatrix_xyz_v2( xyc_nor, Tx, Ty, Tz, rx, ry, rz );

% data 
data = gdata;   


MT = data;
D = xyct;

xyz_output = interpolation_3d_xyz(D, MT(:,[1 2]));
delta = xyz_output(:,3) - MT(:,3);
Err2 = inpaint_nans(delta);
E = rms(Err2);

gcnt = gcnt+1;
cnt = mod(gcnt,10);

if 0 %cnt == 1
    figure
    hold on
    plot3(D(:,1), D(:,2), D(:,3), 'r.');
    plot3(gdata(:,1), gdata(:,2), gdata(:,3), 'b.');
    debug = 1;
end

end
