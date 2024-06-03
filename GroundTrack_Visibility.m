function GroundTrack_Visibility(satellite_name, Gamma, gamma)
% This function generates a ground track plot for the latitude and
% longitude coordinates for a given satellite. The input variables are the
% following:
%
% - Gamma = nx4 array of time and coordinates. Must be in s, degrees, and m.
% - gamma = nx4 array of time and visible coordinates. Must be in s, degrees, and m.
%
% The function will output the associated ground track as a figure, and 
% when the spacecraft is visible from the ground station. Note that the 
% starting point of the ground track will be marked by a green point and 
% the final point by a yellow point.

Lat_G = Gamma(:, 2);
Lat_g = gamma(:, 2);
Lon_G = Gamma(:, 3);
Lon_g = gamma(:, 3);

% Modify the longitude coordinates if necessary.
Lon_G = Lon_G + 360*(Lon_G < 0);               % Get longitude in range 0-360.
Lon_g = Lon_g + 360*(Lon_g < 0);

% Shift longitude cordinates to comply with -180 to 180 range.
Lon_G = Lon_G - 360*(Lon_G > 180);
Lon_g = Lon_g - 360*(Lon_g > 180);

% Plot the ground track.
hold on;
plot(Lon_G, Lat_G, '.','LineWidth', 1.5, 'Color', [0.6350 0.0780 0.1840]);
plot(Lon_g, Lat_g, '.','LineWidth', 1.5, 'Color', [0.365 0.922 0.816]);


% Configure plot.
axis equal;
set(gca,'XLim',[-180 180],'YLim',[-90 90], ... 
    'XTick', [-180 -120 -60 0 60 120 180], ...
    'Ytick',[-90 -60 -30 0 30 60 90]);
hold on;

% Highlight the starting and ending points.
scatter(Lon_G(1), Lat_G(1), ...
        'filled', 'MarkerEdgeColor', [0 0 0], ...
        'MarkerFaceColor', [0.4660 0.6740 0.1880])   % Start

scatter(Lon_G(end), Lat_G(end), ...
        'filled', 'MarkerEdgeColor', [0 0 0], ...
        'MarkerFaceColor', [0.9290 0.6940 0.1250])   % End 

% Add background to figure.
im = imread('Blue_Marble_2002.png');
handle = image([-180 180], -[-90 90], im);
uistack(handle, 'bottom')

% Add plot labels.
xlabel('Longitude [Deg]');
ylabel('Latitude [Deg]');
title([satellite_name ' Ground Track and Visibility Zone']);

hold off

end