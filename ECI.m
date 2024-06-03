function [a,e_out,i,Omega,omega,f] = ECI(r,v,mu)

%% Calculation of Orbital Elements from r and v

% Energy E, Semi-major axis a, and Momentum h

E = 1/2 * norm(v)^2 - mu./norm(r);
a = -mu/(2*E); % m
h = cross(r,v);

% Eccentricity e

e = 1/mu * (cross(v,h) - mu/norm(r) .* r);
e_out = norm(e);

% Inclination i

i = acos(h(3)/norm(h));

% Right Ascending Node Ω

k = [0 0 1];
y = cross(k, h);
n = y/norm(h);

Omega = acos(n(1)/norm(n));

% 5/ Argument of Periapsis ω

omega = acos(dot(n,e)/(norm(e)*norm(n)));
if dot(e,k) < 0
    omega = 2*pi - omega;
end

% True Anomaly f

f = acos(dot(e,r)/(norm(e)*norm(r)));
end 