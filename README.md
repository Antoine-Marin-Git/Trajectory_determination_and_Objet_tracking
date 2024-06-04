Overview
========

The following will present how to switch between, Earth-Centered-Earth-Fixed (ECEF), Earth-Centered-Inertial (ECI), and Topographic (longitude/latitude/altitude)
coordinates frames. These tools are helpful to perform groundtracks of space/aerial assets, determine orbital elements from position/velocity and vice versa,
perform spacecraft/aircraft visibility check when object is tracked from a ground station, size link budgets for communication purposes, and so forth.

# Coordinates Frames, Orbital Elements, Position and Velocity Determination

Position and velocity vectors of a satellite, orbiting the Earth for instance, are related to its 6 orbital elements that describe in an unambiguous way its orbit
as shown Fig. 1. 

![alt text](Graphics/Orbit_Elem.PNG)

For instance, a satellite evolving around the Earth with a position vector specigied 𝒓 = 6045𝒊 + 3490𝒋 + 0𝒌 𝑘𝑚 and a velocity vector specified 
by 𝒗 = −2.457𝒊 + 6.618𝒋 + 2.533𝒌 𝑘𝑚/𝑠
