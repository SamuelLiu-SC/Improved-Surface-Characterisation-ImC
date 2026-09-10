function [xyz] = generate_sinsin_surface_xyz(x, y, scale1, scale2, sx, sy)
% generate sinsin surface
% input:  x, y, scale1, scale2, sx, sy
% output: xx, yy, zz
[xx,yy] = meshgrid(x,y);
zz = 0.5*sin(xx*2*pi/sx)*scale1 + 0.5*sin(yy*2*pi/sy)*scale2;

[ xyz ] = convert_mesh_to_xyz( xx, yy, zz );

end
