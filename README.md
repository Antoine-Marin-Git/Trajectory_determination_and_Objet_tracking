Overview
========

The following will present how to switch between, Earth-Centered-Earth-Fixed (ECEF), Earth-Centered-Inertial (ECI), and Topographic (longitude/latitude/altitude)
coordinates frames. These tools are helpful to perform groundtracks of space/aerial assets, determine orbital elements from position/velocity and vice versa,
perform spacecraft/aircraft visibility check when object is tracked from a ground station, size link budgets for communication purposes, and so forth.

# Coordinates Frames, Orbital Elements, Position and Velocity Determination

The ECI and ECEF frames are both Earth-centered, but the ECEF frame takes into account the rotation of the Earth on its spin axis as described Fig. 1 and Fig. 2

![alt text](Graphics/ECI.PNG)
![alt text](Graphics/ECEF.PNG)

A satellite's orbite, around the Earth for instance, is described by 6 orbital elements that qualify in an unambiguous way its orbit, as shown Fig. 3. 

![alt text](Graphics/Orbit_Elem.PNG)

Fig 3. Orbital elements describing satellites orbits

Position and velocity vectors in ECI of the satellite are related to its orbital elements via equations derived from orbital mechanics. Often, the true anomaly
$\theta$ is not known, but the time $t$ after crossing perigee at which we want to know the spacecraft position and velocity vectors is.
For instance, a satellite orbiting the Earth with a position vector specified by 𝒓 = 6045𝒊 + 3490𝒋 + 0𝒌 𝑘𝑚 and a velocity vector specified 
by 𝒗 = −2.457𝒊 + 6.618𝒋 + 2.533𝒌 𝑘𝑚/𝑠 in ECI coordinates frame would have the following orbital elements (cf code [ECI.m](https://github.com/Antoine-Marin-Git/Trajectory_determination_and_Objet_tracking/tree/master/ECI.m)).


