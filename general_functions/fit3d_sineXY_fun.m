function [E] = fit3d_sineXY_fun( x )
% evaluate the ERR


global gdata
global xa 
global ya

Tx = x(1);
Ty = x(2);
Tz = x(3);
rx = x(4);
ry = x(5);
rz = x(6);

scale1 = x(7);
scale2 = x(8);
sx = x(9);
sy = x(10);

[xyz] = generate_sinsin_surface_xyz(xa, ya, scale1, scale2, sx, sy);

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


if 0 %cnt == 1
    figure
    hold on
    plot3(D(:,1), D(:,2), D(:,3), 'r.');
    plot3(gdata(:,1), gdata(:,2), gdata(:,3), 'b.');
%     x
    debug = 1;
end

end