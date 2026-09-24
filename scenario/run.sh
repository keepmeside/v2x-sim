#!/usr/bin/env bash
set -euo pipefail
if [[ -z "${OMNETPP_HOME:-}" && -f "${SIM_ROOT:-$HOME/sim-stack}/env.sh" ]]; then
  source "${SIM_ROOT:-$HOME/sim-stack}/env.sh"
fi
: "${OMNETPP_HOME:?Run ./setup-macos.sh or ./setup-sim.sh first}"
: "${INET_HOME:?Run ./setup-macos.sh or ./setup-sim.sh first}"
: "${SIMU5G_HOME:?Run ./setup-macos.sh or ./setup-sim.sh first}"
cd "$(dirname "$0")"
exec "$OMNETPP_HOME/bin/opp_run" -u Cmdenv \
  -n "$SIMU5G_HOME;$INET_HOME" \
  -f omnetpp.ini -c V2XBaseline "$@"
