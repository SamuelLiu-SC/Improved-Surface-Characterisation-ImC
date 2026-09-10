function [ outputdata ] = cut_data_3d_B( inputdata, xmin, xmax, ymin, ymax, zmin, zmax )

    x_orig = inputdata(:, 1);
    y_orig = inputdata(:, 2);
    z_orig = inputdata(:, 3);

    if xmin ~= xmax
        xidx = find(x_orig >= xmin & x_orig <= xmax);
        x_orig = x_orig(xidx);
        y_orig = y_orig(xidx);
        z_orig = z_orig(xidx);          
    end

    
    if ymin ~= ymax
        yidx = find(y_orig >= ymin & y_orig <= ymax); 
        x_orig = x_orig(yidx);
        y_orig = y_orig(yidx);
        z_orig = z_orig(yidx);          
    end
   
    
    if zmin ~= zmax
        zidx = find(z_orig >= zmin & z_orig <= zmax);
        x_orig = x_orig(zidx);
        y_orig = y_orig(zidx);
        z_orig = z_orig(zidx);          
    end
 
  
    outputdata = [x_orig, y_orig, z_orig];
    
end

