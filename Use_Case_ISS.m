close all; clear all; clc

% Constants

mu = 3.986004418e14; % m3/s2
R_earth = 6371e3; % m

% ISS Orbital Elements (06/05/2024 at 13:08:21)

a_ISS = 6.796620707e6; % m
e_ISS = 0.0006059; % (.)
t_ISS = 30000; % s
i_ISS = 51.6439; % deg
Omega_ISS = 11.3423; % deg
omega_ISS = 278.6277; % deg

   % Ground Track iteration

vec_lat_ISS = zeros(t_ISS, 1);
vec_long_ISS = zeros(t_ISS, 1);
vec_alt_ISS = zeros(t_ISS, 1);
vec_lat_ISS_ECI = zeros(t_ISS, 1);
vec_long_ISS_ECI = zeros(t_ISS, 1);
vec_alt_ISS_ECI = zeros(t_ISS, 1);

for t = 1:t_ISS % Assignment of values for each row of the different vectors
    [vec_lat_ISS(t), vec_long_ISS(t), vec_alt_ISS(t)] = ECI_2_ECEF(a_ISS, e_ISS, t, deg2rad(i_ISS), deg2rad(Omega_ISS), deg2rad(omega_ISS));
    [vec_lat_ISS_ECI(t), vec_long_ISS_ECI(t), vec_alt_ISS_ECI(t)] = ECI_GroundTrack(a_ISS, e_ISS, t, deg2rad(i_ISS), deg2rad(Omega_ISS), deg2rad(omega_ISS));
end

GroundTrack(vec_lat_ISS, vec_long_ISS, 'ISS')
Plot3D_Earth(vec_lat_ISS, vec_long_ISS, vec_alt_ISS, figure)
Plot3D_Earth(vec_lat_ISS_ECI, vec_long_ISS_ECI, vec_alt_ISS_ECI, figure)

    % Tracking from Ground Station

t_vector_ISS = zeros(t_ISS, 1);  

for t = 1:t_ISS 
    t_vector_ISS(t) = t_vector_ISS(t) + t;
end

Gamma_ISS = [t_vector_ISS, vec_lat_ISS, vec_long_ISS, vec_alt_ISS];
gamma_ISS = GSVisibilityCheck(Gamma_ISS); % Computation of gamma, whether the GS can track the Sat or not

figure;
GroundTrack_Visibility('ISS', Gamma_ISS, gamma_ISS)
Plot3D_Earth_Visibility(Gamma_ISS, gamma_ISS, figure)

    % Polar Plot from Ground Station

[azi_ISS, ele_ISS] = GSsatLOS(gamma_ISS);
azi_and_ele_ISS = [azi_ISS, ele_ISS];

figure;
polarplot(deg2rad(azi_and_ele_ISS(:,1)), 90 - azi_and_ele_ISS(:,2),'r.')
hold on
rlim([0, 90])
ax = gca;
ax.ThetaZeroLocation = 'top';
ax.ThetaDir = 'clockwise';
ax.RTickLabel = {};

 % Starting point

polarplot(deg2rad(azi_and_ele_ISS(1, 1)), 90 - azi_and_ele_ISS(1, 2), 'o', ... % Plot the point
    'MarkerEdgeColor', [0 0.75 0], 'MarkerFaceColor', [0 0.75 0]);   

time_start = gamma_ISS(1,1);
azimuth_start = azi_and_ele_ISS(1, 1);
elevation_start = azi_and_ele_ISS(1, 2);

text(deg2rad(azimuth_start), 90 - elevation_start, sprintf('(%.2f, %.2f, %.2f)', time_start, azimuth_start, elevation_start), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top'); % Assigns the text box

    % Ending point

polarplot(deg2rad(azi_and_ele_ISS(end, 1)), 90 -azi_and_ele_ISS(end, 2), 'o', ... % Plot the point
    'MarkerEdgeColor', [1 0.6471 0], 'MarkerFaceColor', [1 0.6471 0]);    

time_end = gamma_ISS(end,1);
azimuth_end = azi_and_ele_ISS(end, 1);
elevation_end = azi_and_ele_ISS(end, 2);

text(deg2rad(azimuth_end), 90 - elevation_end, sprintf('(%.2f, %.2f, %.2f)', time_end, azimuth_end, elevation_end), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top'); % Assigns the text box

    % Max Elevation

[ele_max, index] = max(azi_and_ele_ISS(:, 2)); % find the max ele and associated time

polarplot(deg2rad(azi_and_ele_ISS(index, 1)), 90 -azi_and_ele_ISS(index, 2), 'o', ... % Plot the point
    'MarkerEdgeColor', [0 0 0.8], 'MarkerFaceColor', [0 0 0.8]); 

time_max = gamma_ISS(index,1);
azimuth_max = azi_and_ele_ISS(index, 1);
elevation_max = azi_and_ele_ISS(index, 2);
text(deg2rad(azimuth_max), 90 - elevation_max, sprintf('(%.2f, %.2f)', time_max, elevation_max), 'HorizontalAlignment', 'right', 'VerticalAlignment', 'top'); % Assigns the text box

title('ISS Polar Plot from Houston MCC');