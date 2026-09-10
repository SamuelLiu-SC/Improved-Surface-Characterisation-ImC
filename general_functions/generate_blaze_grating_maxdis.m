function [xx, yy, zz, xyz] = generate_blaze_grating_maxdis(xlen, ylen, x1, x2, maxdis, height, ifdisplay)
% generate blaze grating surface
% based on generate_profile_triangle_v2_maxdis

circlenumber = floor(xlen/(x1+x2));

[x, z, profile] = generate_profile_triangle_v2_maxdis(x1, x2, maxdis, height, circlenumber);

if ifdisplay
show_profile_v2_profile(profile); 
axis normal
end

% if ifdisplay
% figure
% plot(x, z, 'x')
% end

yres = maxdis;
y = 0:yres:ylen;

[xx, yy] = meshgrid(x, y);
zz = repmat(z, 1, size(xx,1));
zz=zz';

if ifdisplay
display_3d_color(xx, yy, zz, '', 'x', 'y', 'z');
end 

[ xyz ] = convert_mesh_to_xyz( xx, yy, zz );


end