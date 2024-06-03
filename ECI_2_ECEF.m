%% WORKS ONLY IF ASSUMING e = 0 (sphere)

function [lat, long, alt] = ECI_2_ECEF(a, e, t, i, Omega, omega)

if a<0
    a = abs(a);
end

param = a*(1-e^2);

% Derivation of theta at t 

M_0 = 0;

E = Kepler_Solver(t, e, M_0, a); % .

theta = 2*atan(sqrt((1 + e)/(1 - e))*tan(E/2)); 
r_norm = param/(1+e*cos(theta));

p = [1 0 0];
q = [0 1 0];

r_ini = r_norm*cos(theta)*p + r_norm*sin(theta)*q;

r_ECI = Rotation("z", -Omega)*Rotation("x",-i)*Rotation("z", -omega)*r_ini';

Earth_spin = 2*pi/86164; % rad/s
R_earth = 6371e3; % m

r_ECEF = Rotation("z", Earth_spin*t)*r_ECI;

lat = rad2deg(pi/2 - acos(r_ECEF(3)/norm(r_ECEF)));
long = rad2deg(atan2(r_ECEF(2),r_ECEF(1)));
alt = norm(r_ECEF) - R_earth;

end