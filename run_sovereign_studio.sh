#!/usr/bin/env bash
set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"

echo "=================================================="
echo "⚡ SOVEREIGN STUDIO — BARE-METAL MAINFRAME DESKTOP"
echo "=================================================="

# 1. Check/Start Studio Bridge Daemon
if ! lsof -i :8820 > /dev/null 2>&1; then
    echo "Starting Sovereign Studio Bridge daemon on port 8820..."
    python3 "$DIR/backend/studio_bridge.py" > "$DIR/backend/bridge.log" 2>&1 &
    sleep 1
else
    echo "Sovereign Studio Bridge daemon already running on port 8820."
fi

# 2. Build Release binary if not built
if [ ! -f "$DIR/.build/release/SovereignStudio" ]; then
    echo "Building Sovereign Studio release binary..."
    swift build -c release
fi

echo "Launching Sovereign Studio Native macOS App..."
"$DIR/.build/release/SovereignStudio"
