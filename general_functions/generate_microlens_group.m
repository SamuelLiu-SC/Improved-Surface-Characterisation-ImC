function xyz_g = generate_microlens_group(R, d, res_xy, len_xy, num_x, num_y)



[xyz, xx, yy, zz, xyz_e, xx_e, yy_e, zz_e] = generate_microlens_seperated_element(R, d, res_xy, len_xy);

x = xyz_e(:,1);
y = xyz_e(:,2);
z = xyz_e(:,3);

xyz_g = zeros(size(xyz_e, 1)*num_x*num_y, 3);

for i=0:num_y-1   
    for j=0:num_x-1
        xyz_g((1:size(xyz_e, 1))+(i*num_x+j)*size(xyz_e, 1),:) = [x+j*len_xy y+i*len_xy z];
    end
end

if 0
[ pointsnum ] = display_xyz_data_v2( xyz_g, 1 );
axis normal
end



end