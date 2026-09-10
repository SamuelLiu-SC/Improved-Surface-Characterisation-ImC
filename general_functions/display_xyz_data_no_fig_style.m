function [ pointsnum ] = display_xyz_data_no_fig_style( xyz, method, downsamplerate, inversez, style)
    
    x_orig = xyz(:,1);
    y_orig = xyz(:,2);
    z_orig = xyz(:,3);

    x = x_orig(1:downsamplerate:end);
    y = y_orig(1:downsamplerate:end);
    z = z_orig(1:downsamplerate:end); % * 1000;
    
    if method == 1
        % figure;
        tri = delaunay(x, y);
        h = trisurf(tri, x, y, z);  
        set(h, 'EdgeColor', 'none')
        axis equal  
        xlabel('x')
        ylabel('y')
        zlabel('z')
        grid on;    
        set(gca,'YDir','reverse');    
        %set(gca,'ZDir','reverse'); 
        if inversez == 1
            set(gca,'ZDir','reverse'); 
        end        
        view([0 90]);
    end
    
     if method == 2
        % figure;
        plot3(x, y, z, style);
        axis equal  
        xlabel('x')
        ylabel('y')
        zlabel('z')
        grid on;    
        %set(gca,'YDir','reverse');  
        %set(gca,'ZDir','reverse'); 
        if inversez == 1
            set(gca,'ZDir','reverse'); 
        end        
        view([0 90]);
     end
    
    pointsnum = size(x_orig, 1);
    
end

