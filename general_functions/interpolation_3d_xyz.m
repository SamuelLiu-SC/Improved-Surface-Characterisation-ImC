function xyz_output = interpolation_3d_xyz(xyz_input, xy_look)
% interpolate xyz data at xy location 

%tic
F = scatteredInterpolant(xyz_input(1:1:end,1),xyz_input(1:1:end,2),xyz_input(1:1:end,3),'natural');
z = F(xy_look(1:1:end,1),xy_look(1:1:end,2));
xyz_output = [xy_look(1:1:end,1) xy_look(1:1:end,2) z];
%toc

end