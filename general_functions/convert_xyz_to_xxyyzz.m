function [ xx, yy, zz ] = convert_xyz_to_xxyyzz( xyz, xsize, ysize)
%convert the xyz point cloud to mesh xx, yy, zz data
%   input, output

x = xyz(:,1);
y = xyz(:,2);
z = xyz(:,3);

xx = reshape(x, xsize, ysize);
yy = reshape(y, xsize, ysize);
zz = reshape(z, xsize, ysize);


end

