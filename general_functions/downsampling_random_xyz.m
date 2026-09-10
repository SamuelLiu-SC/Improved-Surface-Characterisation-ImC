function [ xyzds ] = downsampling_random_xyz( xyz, interal )
%downsampling random xyz data

data_size = size(xyz, 1);
data_size_after = ceil(data_size/interal);

r = randperm(data_size, data_size_after);

xyzds = xyz(r, :);

end

