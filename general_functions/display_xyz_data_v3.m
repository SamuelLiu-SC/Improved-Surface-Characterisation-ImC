function [ pointsnum ] = display_xyz_data_v3( xyz, downsamplerate, no_long_edge )

    
    x_orig = xyz(:,1);
    y_orig = xyz(:,2);
    z_orig = xyz(:,3);

    x = x_orig(1:downsamplerate:end);
    y = y_orig(1:downsamplerate:end);
    z = z_orig(1:downsamplerate:end); % * 1000;
    
    %if method == 1
        figure;
        tri = delaunay(x, y);
		if no_long_edge
		% find the long edges 
		edges_length = zeros(size(tri));
		edges_length(:,1) = sqrt((x(tri(:,1)) - x(tri(:,2))).^2 + (y(tri(:,1)) - y(tri(:,2))).^2);
		edges_length(:,2) = sqrt((x(tri(:,1)) - x(tri(:,3))).^2 + (y(tri(:,1)) - y(tri(:,3))).^2);
		edges_length(:,3) = sqrt((x(tri(:,3)) - x(tri(:,2))).^2 + (y(tri(:,3)) - y(tri(:,2))).^2);
        
        length_avr = mean(mean(edges_length));
        %if no_long_edge
            [row,col] = find(edges_length(:,:) > length_avr*3.1);
            tri(row, :) = [];
        end                
        
        h = trisurf(tri, x, y, z);  
        set(h, 'EdgeColor', 'none')
        axis equal  
        xlabel('x')
        ylabel('y')
        zlabel('z')
        grid on;    

        view([0 90]);
    %end    
    
    pointsnum = size(x_orig, 1);
    
end

