function display_3d_color(xx, yy, zz, dis_title, label_x, label_y, label_z)
figure;
h = surf(xx,yy,zz);    
set(h, 'EdgeColor', 'none')
title(dis_title);
xlabel(label_x);
ylabel(label_y);
zlabel(label_z);    
%set(gca,'ZTick',[-15,0])
c=colorbar; %colormap gray;
ylabel(c,label_z);
view([0 90]);
%grid off;
%axis equal;
axis tight;
%caxis([0 50]);
end
