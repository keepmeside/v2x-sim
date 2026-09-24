# Minimal V2X scenario

The SUMO files define a 1 km two-lane road and one vehicle route. Use them as the mobility input for a Simu5G/INET network containing one NR gNodeB colocated with an RSU and a cloud host.

The exact Simu5G NED network should be based on the matching example shipped in `$SIMU5G_HOME` because module names and gate parameters are version-specific. Start from `simu5g/simulations/NR/` and replace its mobility manager with `TraCIMobility` from Veins.
