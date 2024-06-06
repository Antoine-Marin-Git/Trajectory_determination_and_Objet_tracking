%% WORKS ONLY IF ASSUMING SPHERE

function [lat, long, alt] = ECI_GroundTrack(a, e, t, i, Omega, omega)

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

R_earth = 6371e3; % m

lat = rad2deg(pi/2 - acos(r_ECI(3)/norm(r_ECI)));
long = rad2deg(atan2(r_ECI(2),r_ECI(1)));
alt = norm(r_ECI) - R_earth;

end