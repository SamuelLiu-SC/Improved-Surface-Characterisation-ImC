function [xc, zc, profile] = generate_profile_triangle_v2_maxdis(x1, x2, maxdis, height, circlenumber)
% generate profile triangle, v2, specified max distance 
% triangle grating profile 
% input 
% output 


len1 = sqrt(x1^2 + height^2);
len2 = sqrt(x2^2 + height^2);

num1 = ceil(len1/maxdis);
num2 = ceil(len2/maxdis);

xc1 = linspace(0, x1, num1+1 );
zc1 = linspace(0, height, num1+1 );

xc2 = linspace(x1, x1+x2, num2+1 );
zc2 = linspace(height, 0, num2+1 );


xcs = [xc1(1:end-1) xc2(1:end-1)];
zcs = [zc1(1:end-1) zc2(1:end-1)];

xa = [];
za = [];
circlenumber = floor(circlenumber);

for i = 1:circlenumber

    xa = [xa xcs + (i-1)*(x2+x1)];
    za = [za zcs];

end

% last point 
x_l = xcs + (i)*(x2+x1);
xa = [xa x_l(1)];
za = [za zcs(1)];

xc = xa';
zc = za';

profile = [xc zc];

end