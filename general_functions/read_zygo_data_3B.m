function data_xyz = read_zygo_data_3B(filename, x_size, y_size, pix2mm)
% read the zygo data from .xyz file

% replace nan 
rp1 = replaceinfile('No Data', 'NaN', filename, 'temp.out');


fid=fopen('temp.out','r');

disp(filename);

% read the head
tline1 = fgetl(fid);    
tline2 = fgetl(fid);    
tline3 = fgetl(fid);    
tline4 = fgetl(fid);    
tline5 = fgetl(fid);    
tline6 = fgetl(fid);    
tline7 = fgetl(fid);    
tline8 = fgetl(fid);    
tline9 = fgetl(fid);    
tline10 = fgetl(fid);    
tline11 = fgetl(fid);    
tline12 = fgetl(fid);    
tline13 = fgetl(fid);    
tline14 = fgetl(fid);    

% read the data
allData = fscanf(fid,'%f %f %f',[3, x_size*y_size]); 

allData(1, :) = 1000 * pix2mm * allData(1, :);
allData(2, :) = 1000 * pix2mm * allData(2, :);

%[x_nan, y_nan, z_nan] = remove_NaN(allData(1, :), allData(2, :), allData(3, :));

% only need the z data
data_xyz = allData';

fclose(fid);