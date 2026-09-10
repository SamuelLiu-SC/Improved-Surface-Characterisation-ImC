function [xyz, xx, yy, zz, xyz_e, xx_e, yy_e, zz_e] = generate_microlens_seperated_element(R, d, res_xy, len_xy)
% generate micro lens element, 
% R is the large radius, d is the small diameter	
% res_xy is the resolution of points in xy direction 
% len_xy is the len in xy direction  
% xyz is a 3D array

h = sqrt(R^2 - (d/2)^2);

x = 0:res_xy:len_xy; 
y = 0:res_xy:len_xy; 

x = x - 0.5*len_xy;
y = y - 0.5*len_xy;

[xx, yy] = meshgrid(x,y);
zz = zeros(size(xx));

[ xyz ] = convert_mesh_to_xyz( xx, yy, zz );
lx = xyz(:,1);
ly = xyz(:,2);
lz = xyz(:,3);
nz = xyz(:,3);

idx = find(xyz(:,1).^2 + xyz(:,2).^2 < (d/2).^2);

nz(idx) = sqrt(R^2 - xyz(idx,1).^2 - xyz(idx,2).^2) - h;

xyz2 = [lx, ly, nz];

if 0
[ pointsnum ] = display_xyz_data_v2( xyz2, 1 );
axis normal
end

[ xx, yy, zz ] = convert_xyz_to_xxyyzz( xyz2, sqrt(length(xyz2)), sqrt(length(xyz2)));
xyz = xyz2;


%% without last edge data 
[xx_e, yy_e] = meshgrid(x(1:end-1),y(1:end-1));
zz_e = zeros(size(xx_e));

[ xyz_e ] = convert_mesh_to_xyz( xx_e, yy_e, zz_e );
lx_e = xyz_e(:,1);
ly_e = xyz_e(:,2);
lz_e = xyz_e(:,3);
nz_e = xyz_e(:,3);

idx_e = find(xyz_e(:,1).^2 + xyz_e(:,2).^2 < (d/2).^2);

nz_e(idx_e) = sqrt(R^2 - xyz_e(idx_e,1).^2 - xyz_e(idx_e,2).^2) - h;

xyz2_e = [lx_e, ly_e, nz_e];

if 0
[ pointsnum ] = display_xyz_data_v2( xyz2_e, 1 );
axis normal
end

[ xx_e, yy_e, zz_e ] = convert_xyz_to_xxyyzz( xyz2_e, sqrt(length(xyz2_e)), sqrt(length(xyz2_e)));
xyz_e = xyz2_e;

end