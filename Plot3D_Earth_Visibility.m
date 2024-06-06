function Plot3D_Earth_Visibility(Gamma, gamma, fig)
% This function creates a 3-dimensional representation of the orbit of a
% given satellite based on the vehicle's latitude and longitude
% coordinates. The function inputs are as follows:
%
% - Lat = nx1 array of latitude coordinates. Must be in degrees.
% - Lon = nx1 array of longitude coordinates. Must be in degrees.
% - h = nx1 array of altitude coordinates. Must be in meters.
% - fig = figure handle to generate the plot in. For example, created a
%         figure as follows: f = figure(1), then 'f' would be 'fig'.
%
% The function outputs the orbit overlapped on a 3-dimensional
% representation of the Earth. Note that the function inputs can either be
% in the Earth-Centered Earth-Fixed (ECEF) or Earth-Centered Inertial (ECI)
% reference frames.
%

% Extract figure.
f = figure(fig);

% Define Earth parameters.
Re = 6.3712e6;                               % Equatorial radius [m].

% Compute radius from altitude.

h_G = Gamma(:, 4);
h_g = gamma(:, 4);

r_G = h_G + Re;                                  % Radius of position [m].
r_g = h_g + Re;

% Compute vehicle x-y-z coordinates from latitude and longitude. 

Lat_G = Gamma(:, 2);
Lat_g = gamma(:, 2);
Lon_G = Gamma(:, 3);
Lon_g = gamma(:, 3);

xs_G = cosd(Lon_G).*cosd(Lat_G).*r_G;
ys_G = sind(Lon_G).*cosd(Lat_G).*r_G;
zs_G = sind(Lat_G).*r_G;

xs_g = cosd(Lon_g).*cosd(Lat_g).*r_g;
ys_g = sind(Lon_g).*cosd(Lat_g).*r_g;
zs_g = sind(Lat_g).*r_g;

% Import topographic map of the Earth.
image = '1024px-Land_ocean_ice_2048.jpg';
set(gca, 'NextPlot','add', 'Visible','off');

% Configure plot settings.
axis auto;
axis vis3d;
hold on;

% Create ellipsoid coordinates.
[x, y, z] = ellipsoid(0, 0, 0, Re, Re, Re, 180);

% Generate Earth figure.
globe = surf(x, y, -z, 'FaceColor', 'none', 'EdgeColor', 0.5*[1 1 1]);
view([30,20]);

% Add texture to Earth figure.
cdata = imread(image);
set(globe, 'FaceColor', 'texturemap', 'CData', cdata, ...
    'FaceAlpha', 1, 'EdgeColor', 'none');
set(f,'color','k');

% Plot the orbit.
plot3(xs_G, ys_G, zs_G, '.','LineWidth', 1.5, 'Color', [0.6350 0.0780 0.1840]);
plot3(xs_g, ys_g, zs_g, '.','LineWidth', 1.5, 'Color', [0.365 0.922 0.816]);

% Highlight the starting and ending points.
scatter3(xs_G(1), ys_G(1), zs_G(1), ...
        'filled', 'MarkerEdgeColor', [0 0 0], ...
        'MarkerFaceColor', [0.4660 0.6740 0.1880])   % Start

scatter3(xs_G(end), ys_G(end), zs_G(end), ...
        'filled', 'MarkerEdgeColor', [0 0 0], ...
        'MarkerFaceColor', [0.9290 0.6940 0.1250])   % End 

end