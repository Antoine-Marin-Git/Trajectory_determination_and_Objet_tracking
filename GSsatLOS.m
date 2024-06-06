function [azi, ele] = GSsatLOS(gamma)

% Constants

R_earth = 6371e3; % m

% Generation of the Ground Station vector (Houston Mission Control Center)

alt = 0; % m
lat = 29.551811; % deg
long = -95.098228; % deg

M_ECEF_GS = [cos(deg2rad(long))*cos(deg2rad(lat)) % Rotation Matrix for the GS in ECEF
             sin(deg2rad(long))*cos(deg2rad(lat))
             sin(deg2rad(lat))];

r_GS = (R_earth + alt)*M_ECEF_GS; % r_GS in ECEF

azi = zeros(size(gamma, 1),1);
ele = zeros(size(gamma, 1),1);

%[azi, ele] = zeros(size(gamma, 1),2);

for t = 1:size(gamma, 1)

    % Rotation Matrix from ECEF to TOPO

    cos_lat = cos(deg2rad(gamma(t,2)));
    cos_long = cos(deg2rad(gamma(t,3)));
    sin_lat = sin(deg2rad(gamma(t,2)));
    sin_long = sin(deg2rad(gamma(t,3)));

    M_ECEF_sat = [cos_long*cos_lat % Rotation Matrix for the Sat in ECEF
                  sin_long*cos_lat
                  sin_lat];

    % Computation of satellite's position vector in ECEF

    r_sat = (R_earth + gamma(t,4))*M_ECEF_sat;

    % Computation of the Line-of-Sight vector in ECEF

    n_LOS_ECEF = (r_sat - r_GS)/norm(r_sat - r_GS); 

        % Rotation Matrix from ECEF to TOPO

    M_ECEF_2_TOPO = [-sin(deg2rad(long)) cos(deg2rad(long)) 0 % Rotation Matrix from ECEF to TOPO
                     -sin(deg2rad(lat))*cos(deg2rad(long)) -sin(deg2rad(lat))*sin(deg2rad(long)) cos(deg2rad(lat))
                     cos(deg2rad(lat))*cos(deg2rad(long)) cos(deg2rad(lat))*sin(deg2rad(long)) sin(deg2rad(lat))];
    n_LOS = M_ECEF_2_TOPO*n_LOS_ECEF;

    % Computation of azimuth and elevation at each timestep

    beta = atan2(n_LOS(2), n_LOS(1));
    
    azi_value = rad2deg(pi/2 - beta);
    ele_value = rad2deg(asin(n_LOS(3)));
    
    azi(t) = azi_value;
    ele(t) = ele_value;
end