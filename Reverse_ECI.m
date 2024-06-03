function [r, v] = Reverse_ECI(mu, a, e, t, i, Omega, omega)

if a<0
    a = abs(a);
end

param = a*(1-e^2);

% Derivation of theta at t = 9h 

M_0 = 0;

E = Kepler_Solver(t, e, M_0, a); % .

theta = 2*atan(sqrt((1 + e)/(1 - e))*tan(E/2)); 
r_norm = param/(1+e*cos(theta));

p = [1 0 0];
q = [0 1 0];

r_ini = r_norm*cos(theta)*p + r_norm*sin(theta)*q;
v_ini = sqrt(mu/param)*(-sin(theta)*p + (e+cos(theta))*q);

r = Rotation("z", -Omega)*Rotation("x",-i)*Rotation("z", -omega)*r_ini';
v = Rotation("z", -Omega)*Rotation("x",-i)*Rotation("z", -omega)*v_ini';

end