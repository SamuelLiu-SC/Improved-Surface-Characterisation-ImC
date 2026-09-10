function show_profile_v2_profile(profile)
% show profile

        figure
        plot(profile(:,1), profile(:,2), '.k');
        axis equal
        xlabel('x/µm');
        ylabel('z/µm');
        grid on

end