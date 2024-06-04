Overview
========

The following will present how to switch between Earth-Centered-Earth-Fixed (ECEF), Earth-Centered-Inertial (ECI), and Topographic (longitude/latitude/altitude)
coordinates frames. These tools are helpful to perform groundtracks of space/aerial assets, determine orbital elements from position/velocity and vice versa,
perform spacecraft/aircraft visibility check when object is tracked from a ground station, size link budgets for communication purposes, and so forth.

# Coordinates Frames, Orbital Elements, Position and Velocity Determination

The ECI coordinates frame is described Fig. 1. 

![alt text](Graphics/ECI.PNG)
Fig 1. ECI coordinates frame

A satellite's orbite, around the Earth for instance, is described by 6 orbital elements that qualify in an unambiguous way its orbit, as shown Fig. 2. 

![alt text](Graphics/Orbit_Elem.PNG)

Fig 2. Orbital elements describing satellites orbits

Position and velocity vectors in ECI of the satellite are related to its orbital elements via equations derived from orbital mechanics. Often, the true anomaly
$\theta$ is not known, but the time $t$ after crossing perigee at which we want to know the spacecraft position and velocity vectors is.
For instance, a satellite Sat-1 orbiting the Earth with a position vector specified by 𝒓 = 6045𝒊 + 3490𝒋 + 0𝒌 𝑘𝑚 and a velocity vector specified 
by 𝒗 = −2.457𝒊 + 6.618𝒋 + 2.533𝒌 𝑘𝑚/𝑠 in ECI coordinates frame would have the following orbital elements Fig. 3 (cf code [ECI.m](https://github.com/Antoine-Marin-Git/Trajectory_determination_and_Objet_tracking/tree/master/ECI.m)):

![alt text](Graphics/Orb_elem_from_r_v.PNG)

Fig 3. Orbital elements derived from Sat-1 position and velocity vectors 

Conversely, the code [Reverse_ECI.m](https://github.com/Antoine-Marin-Git/Trajectory_determination_and_Objet_tracking/tree/master/Reverse_ECI.m) gives the position and velocity vectors starting from given orbital elements. For instance, for the ISS being at $t = 100$ s after perigee, $a = 6.796620707 × 10^6$ 𝑚, $𝑖 = 51.6439°$, $𝑒 = 2.404 × 10^{−4}$, $\Omega = 86.8571°$, $\omega = 1.8404°$, the resulting position vector is 𝒓 = 6775.8⃗𝒊 + 381.3⃗𝒋 + 2054.4⃗𝒌 𝑘𝑚. This code needs to solve the Kepler equation, presented in code [Kepler_Solver.m](https://github.com/Antoine-Marin-Git/Trajectory_determination_and_Objet_tracking/tree/master/Kepler_Solver.m), using the Newton-Raphson method, implemented in [NewtRaph.m](https://github.com/Antoine-Marin-Git/Trajectory_determination_and_Objet_tracking/tree/master/NewtRaph.m)


