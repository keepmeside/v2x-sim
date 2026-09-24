#!/usr/bin/env bash
set -euo pipefail
: "${OMNETPP_HOME:?Run: source \"$HOME/sim-stack/env.sh\"}"
: "${INET_HOME:?Run: source \"$HOME/sim-stack/env.sh\"}"
: "${SIMU5G_HOME:?Run: source \"$HOME/sim-stack/env.sh\"}"
cd "$(dirname "$0")"
exec "$OMNETPP_HOME/bin/opp_run" -u Cmdenv \
  -n "$SIMU5G_HOME;$INET_HOME" \
  -f omnetpp.ini -c V2XBaseline "$@"
