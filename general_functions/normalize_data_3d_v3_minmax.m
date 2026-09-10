function [ output_data ] = normalize_data_3d_v3_minmax( input_data )

    input_data_x = input_data(:, 1);
    input_data_y = input_data(:, 2);
    input_data_z = input_data(:, 3);
    
    input_data_x_mean = 0.5*(max(input_data_x) + min(input_data_x));
    input_data_y_mean = 0.5*(max(input_data_y) + min(input_data_y));
    input_data_z_mean = 0.5*(max(input_data_z) + min(input_data_z));
    
    input_data_x_nor = input_data_x - input_data_x_mean;
    input_data_y_nor = input_data_y - input_data_y_mean;
    input_data_z_nor = input_data_z - input_data_z_mean;
    
    
    output_data = [input_data_x_nor, input_data_y_nor, input_data_z_nor];
end

