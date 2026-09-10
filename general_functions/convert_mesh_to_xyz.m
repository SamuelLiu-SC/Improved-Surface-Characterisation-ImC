function [ xyz ] = convert_mesh_to_xyz( xx, yy, zz )
%convert the mesh xx, yy, zz data to xyz point cloud
%   Detailed explanation goes here

xx_r = reshape(xx, size(xx, 1)*size(xx, 2), 1);
yy_r = reshape(yy, size(yy, 1)*size(yy, 2), 1);
zz_r = reshape(zz, size(zz, 1)*size(zz, 2), 1);
xyz = [xx_r yy_r zz_r];

end

