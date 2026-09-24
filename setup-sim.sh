#!/usr/bin/env bash
set -euo pipefail

ROOT="${SIM_ROOT:-$HOME/sim-stack}"
JOBS="${JOBS:-$(nproc)}"
mkdir -p "$ROOT/src" "$ROOT/opt"

clone_tag() {
  local url="$1" dir="$2" tag="$3"
  if [[ ! -d "$dir/.git" ]]; then git clone --depth 1 --branch "$tag" "$url" "$dir"; fi
}

echo "Installing SUMO 1.22.0 under $ROOT/opt/sumo-1.22.0"
SUMO="$ROOT/opt/sumo-1.22.0"
if [[ ! -x "$SUMO/bin/sumo" ]]; then
  git clone --depth 1 --branch v1_22_0 https://github.com/eclipse-sumo/sumo.git "$SUMO"
  CC=/usr/bin/gcc CXX=/usr/bin/g++ cmake -S "$SUMO" -B "$SUMO/build" -DCMAKE_BUILD_TYPE=Release -DPYTHON_BINDINGS=OFF
  cmake --build "$SUMO/build" -j"$JOBS"
  mkdir -p "$SUMO/bin"; cp "$SUMO/build/bin/sumo"* "$SUMO/bin/" 2>/dev/null || true
fi

echo "Downloading OMNeT++ 6.1.0"
OMNET="$ROOT/opt/omnetpp-6.1.0"
if [[ ! -x "$OMNET/bin/opp_run" ]]; then
  git clone --depth 1 --branch omnetpp-6.1.0 https://github.com/omnetpp/omnetpp.git "$OMNET"
  cd "$OMNET"
  cp -n configure.user.dist configure.user
  sed -i 's/^WITH_SCAVE_PYTHON_BINDINGS=.*/WITH_SCAVE_PYTHON_BINDINGS=no/' configure.user
  source setenv -q
  ./configure WITH_QTENV=no
  make -j"$JOBS"
fi

clone_tag https://github.com/inet-framework/inet.git "$ROOT/src/inet" v4.5.4
clone_tag https://github.com/Unipisa/Simu5G.git "$ROOT/src/simu5g" v1.3.0
clone_tag https://github.com/sommer/veins.git "$ROOT/src/veins" veins-5.3.1

source "$OMNET/setenv"
for project in inet simu5g veins; do
  cd "$ROOT/src/$project"
  make makefiles
  make -j"$JOBS"
done

cat > "$ROOT/env.sh" <<EOF
export OMNETPP_HOME="$OMNET"
export INET_HOME="$ROOT/src/inet"
export SIMU5G_HOME="$ROOT/src/simu5g"
export VEINS_HOME="$ROOT/src/veins"
export SUMO_HOME="$SUMO"
export PATH="\$OMNETPP_HOME/bin:\$SUMO_HOME/bin:\$PATH"
EOF
echo "Installed. Run: source $ROOT/env.sh"
