# 5G V2X simulation stack

This workspace targets Ubuntu 22.04 with OMNeT++ 6.1.0, INET 4.5.4, Simu5G 1.3.0, Veins 5.3.1, and SUMO 1.22.0.

## Install

```bash
./setup-sim.sh
source "$HOME/sim-stack/env.sh"
```

The installer puts source trees and builds under `$HOME/sim-stack`. It is safe to rerun after an interrupted build.

## Scenario

`scenario/` contains the starting SUMO road network and a run configuration. The intended path is:

```text
autonomous vehicle (UE) -> Simu5G NR gNodeB/RSU -> UPF/core -> cloud server
                                  ^
                             SUMO mobility via TraCI
```

The supplied network files are deliberately small so that connectivity and packet delay can be validated first. Add application traffic and handover studies after the baseline run succeeds.
