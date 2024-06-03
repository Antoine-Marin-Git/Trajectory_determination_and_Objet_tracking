function [gamma] = GSVisibilityCheck(Gamma)

% Constants

R_earth = 6371e3; % m

% Generation of the Ground Station vector

alt = 0; % m
lat = 48.096; % deg
long = -119.781; % deg

M_ECEF_GS = [cos(deg2rad(long))*cos(deg2rad(lat)) % Rotation Matrix for the GS in ECEF
             sin(deg2rad(long))*cos(deg2rad(lat))
             sin(deg2rad(lat))];

r_GS = (R_earth + alt)*M_ECEF_GS; % r_GS in ECEF

disp('Ground Station ECEF position coordinates:');
disp(r_GS);

% Generation of the Satellite vector and sorting of the valid values

elevation_mask = 20; % deg
gamma = []; 
M_ECEF_2_TOPO = [-sin(deg2rad(long)) cos(deg2rad(long)) 0 % Rotation Matrix from ECEF to TOPO
                 -sin(deg2rad(lat))*cos(deg2rad(long)) -sin(deg2rad(lat))*sin(deg2rad(long)) cos(deg2rad(lat))
                 cos(deg2rad(lat))*cos(deg2rad(long)) cos(deg2rad(lat))*sin(deg2rad(long)) sin(deg2rad(lat))];

for t = 1:size(Gamma, 1)
    cos_lat = cos(deg2rad(Gamma(t,2)));
    cos_long = cos(deg2rad(Gamma(t,3)));
    sin_lat = sin(deg2rad(Gamma(t,2)));
    sin_long = sin(deg2rad(Gamma(t,3)));

    M_ECEF_sat = [cos_long*cos_lat % Rotation Matrix for the Sat in ECEF
                  sin_long*cos_lat
                  sin_lat];
    r_sat = (R_earth + Gamma(t,4))*M_ECEF_sat;

    n_LOS_ECEF = (r_sat - r_GS)/norm(r_sat - r_GS); % Line-of-Sight Vector Construction
    n_LOS = M_ECEF_2_TOPO*n_LOS_ECEF;

    elevation = rad2deg(asin(n_LOS(3))); % Computation of elevation at each timestep

    if elevation > elevation_mask
        gamma = [gamma; Gamma(t,:)]; % If the Sat can be tracked by the GS, adds the time and coordinates in gamma
    end
end