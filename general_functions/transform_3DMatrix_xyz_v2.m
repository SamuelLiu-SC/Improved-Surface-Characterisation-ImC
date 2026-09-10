function [ output ] = transform_3DMatrix_xyz_v2( input, Tx, Ty, Tz, rx, ry, rz )

input = input';

T = [Tx; Ty; Tz];

n = size(input, 2);

eul = [rz, ry, rx];

rotm = eul2rotm(eul);
R = rotm;

output = R * input + repmat(T, 1, n);

output = output';

end

