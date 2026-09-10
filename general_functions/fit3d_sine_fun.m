function [E] = fit3d_sine_fun( x )
% evaluate the ERR

global gxstart
global gxend
global gystart
global gyend
global gres
global gdata
global gcnt


height = x(1);
single_len = x(2);
Tx = x(3);
Ty = x(4);
Tz = x(5);
rx = x(6);
ry = x(7);
rz = x(8);

xstart = gxstart;
xend = gxend;
ystart = gystart;
yend = gyend;
res = gres;

xc = xstart:res:xend;
yc = ystart:res:yend;
[xx, yy] = meshgrid(xc, yc);
zz = 0.5*height*sin(2*pi*xx/single_len);
[ xyz ] = convert_mesh_to_xyz( xx, yy, zz );

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
%     x
    debug = 1;
end

end